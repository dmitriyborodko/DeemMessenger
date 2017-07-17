//
//  DMMessage+CoreDataClass.m
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMMessage+CoreDataClass.h"
#import "DMUser+CoreDataClass.h"
#import "DMUtility.h"
#import "AppDelegate.h"

dispatch_queue_t generateIdQueue() {
    static dispatch_once_t queueCreationGuard;
    static dispatch_queue_t queue;
    dispatch_once(&queueCreationGuard, ^{
        queue = dispatch_queue_create("com.deemMessage.generateIdQueue", 0);
    });
    return queue;
}

@implementation DMMessage

@dynamic type;

#pragma mark - Public Methods

+ (void)createFromWithEncodedData:(NSData *)body
                             type:(DMMessageType)type
                         dateSent:(NSDate *)dateSent
                         senderId:(int16_t)senderId
                compretionHandler:(void(^)(DMMessage *message))completionHandler {
    
    
    dispatch_async(generateIdQueue(), ^{
        NSString *decodedString = [NSString new];
        int64_t newId = [DMMessage generateNewMessageId];
        
        switch (type) {
            case kMessageTypeText: {
                decodedString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                break;
            }
                
            case kMessageTypeImage: {
                decodedString = [DMMessage imageSavedWithMessageId:newId andData:body];
                break;
            }
                
            case kMessageTypeGeolocation: {
                decodedString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                break;
            }
                
                
            default:
                break;
        }
        
        DMMessage *message = [DMMessage createWithType:type
                                       body:decodedString
                                   dateSent:dateSent
                                  messageId:newId
                                   senderId:senderId];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            completionHandler(message);
        });
    });
}

+ (void)createWithText:(NSString *)string
                sender:(DMUser *)sender
     compretionHandler:(void(^)(DMMessage *message))completionHandler {
    
    dispatch_async(generateIdQueue(), ^{
        
        if (!string) {
            completionHandler(nil);
        }
        
        DMMessage *message = [DMMessage createWithType:kMessageTypeText
                                       body:string
                                   dateSent:[NSDate date]
                                  messageId:[DMMessage generateNewMessageId]
                                   senderId:sender.userId
                   ];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            completionHandler(message);
        });
    });
}

+ (void)createWithImage:(UIImage *)image
                 sender:(DMUser *)sender
      compretionHandler:(void(^)(DMMessage *message))completionHandler {
    
    dispatch_async(generateIdQueue(), ^{
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        if (!imageData) {
            completionHandler(nil);
        }
        int64_t newId = [DMMessage generateNewMessageId];
        
        DMMessage *message =  [DMMessage createWithType:kMessageTypeImage
                                    body:[DMMessage imageSavedWithMessageId:newId andData:imageData]
                                dateSent:[NSDate date]
                               messageId:newId
                                senderId:sender.userId
                ];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            completionHandler(message);
        });
        
    });
}

+ (void)createWithCoordinate:(CLLocationCoordinate2D)coordinate
                      sender:(DMUser *)sender
           compretionHandler:(void(^)(DMMessage *message))completionHandler {
    
    dispatch_async(generateIdQueue(), ^{
        
        NSString *coordinateString = [NSString stringWithFormat:@"%g::%g", coordinate.latitude, coordinate.longitude];
        int64_t newId = [DMMessage generateNewMessageId];
        
        DMMessage *message =  [DMMessage createWithType:kMessageTypeGeolocation
                                                   body:coordinateString
                                               dateSent:[NSDate date]
                                              messageId:newId
                                               senderId:sender.userId
                               ];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            completionHandler(message);
        });
        
    });
}

- (NSDictionary *)map {
    NSMutableDictionary *messageDictionary = [NSMutableDictionary new];
    
    NSData *encodedBody;
    switch (self.type) {
        case kMessageTypeText: {
            encodedBody = [self.body dataUsingEncoding:NSUTF8StringEncoding];
            break;
        }
            
        case kMessageTypeImage: {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docs = [paths objectAtIndex:0];
            NSString *path =  [docs stringByAppendingFormat:@"/%@", self.body];
            
            encodedBody = [NSData dataWithContentsOfFile:path];
            break;
        }
            
        case kMessageTypeGeolocation: {
            encodedBody = [self.body dataUsingEncoding:NSUTF8StringEncoding];
            break;
        }
            
        default:
            break;
    }
    
    [messageDictionary setObject:[NSString stringWithFormat:@"%d", self.type] forKey:@"type"];
    [messageDictionary setObject:encodedBody forKey:@"body"];
    [messageDictionary setObject:self.dateSent forKey:@"dateSent"];
    [messageDictionary setObject:[NSString stringWithFormat:@"%lld", self.messageId] forKey:@"messageId"];
    [messageDictionary setObject:[NSString stringWithFormat:@"%lld", self.sender.userId] forKey:@"senderId"];
    
    return [NSDictionary dictionaryWithDictionary:messageDictionary];
}

#pragma mark - Private Methods

+ (DMMessage *)createWithType:(DMMessageType)type
                         body:(NSString *)body
                     dateSent:(NSDate *)dateSent
                    messageId:(int16_t)messageId
                     senderId:(int16_t)senderId {
    
    __block DMMessage *message;
    
    [[AppDelegate managedObjectContext] performBlockAndWait:^{
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([DMMessage class]) inManagedObjectContext:[AppDelegate managedObjectContext]];
        message = [[DMMessage alloc] initWithEntity:entity insertIntoManagedObjectContext:[AppDelegate managedObjectContext]];
        
        message.body = body;
        message.type = type;
        message.sender = [DMUser withId:senderId];
        message.dateSent = dateSent;
        message.messageId = messageId;
        
        NSError *error;
        [[AppDelegate managedObjectContext] save:&error];
        if (error) {
            NSLog(@"Error when saving Core Data - %@", error);
        }
    }];
    
    return message;
}

+ (NSString *)imageSavedWithMessageId:(int16_t)messageId andData:(NSData *)body {
    NSString *imageName = [DMMessage imageNameWithMessageId:messageId];
    NSString *path = [DMUtility pathForImageWithName:imageName];
    
    NSError *writeError = nil;
    [body writeToFile:path options:NSDataWritingAtomic error:&writeError];
    
    if (writeError) {
        return nil;
    } else {
        return imageName;
    }
}

+ (NSString *)imageNameWithMessageId:(int64_t)messageId {
    return [NSString stringWithFormat:@"message_id_%lld.jpg", messageId];
}

+ (int64_t)generateNewMessageId {
    
    int64_t newMessageId;
    
    NSFetchRequest<DMMessage *> *fetchRequest = [DMMessage fetchRequest];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"messageId" ascending:NO]];
    fetchRequest.fetchLimit = 1;
    
    NSError *error = nil;
    NSArray<DMMessage *> *fetchedObjects = [[AppDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Error while fetching objects");
    }
    
    if (!fetchedObjects.count) {
        newMessageId = 0;
    } else {
        NSLog(@"%lld", (fetchedObjects.firstObject.messageId + 1));
        newMessageId = fetchedObjects.firstObject.messageId;
    }
    
    return (newMessageId + 1);
    
}


@end
