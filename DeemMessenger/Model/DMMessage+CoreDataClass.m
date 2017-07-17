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

@interface DMMessage ()

//@property (strong, nonatomic) dispatch_queue_t serialQueue;

@end

@implementation DMMessage

@dynamic type;
//@dynamic serial

#pragma mark - Public Methods

+ (DMMessage *)createFromWithEncodedData:(NSData *)body
                                    type:(DMMessageType)type
                                dateSent:(NSDate *)dateSent
                               messageId:(int16_t)messageId
                                senderId:(int16_t)senderId {
    
    NSString *decodedString = [NSString new];
    
    switch (type) {
        case kMessageTypeText: {
            decodedString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
            break;
        }
            
        case kMessageTypeImage: {
            decodedString = [DMMessage imageSavedWithMessageId:messageId andData:body];
            break;
        }
            
        case kMessageTypeGeolocation: {
            decodedString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
            break;
        }
            
            
        default:
            break;
    }
    
    return [DMMessage createWithType:type
                                body:decodedString
                            dateSent:dateSent
                           messageId:messageId
                            senderId:senderId];
}

+ (DMMessage *)createWithText:(NSString *)string sender:(DMUser *)sender {
    if (!string) {
        return nil;
    }
    
    return [DMMessage createWithType:kMessageTypeText
                                body:string
                            dateSent:[NSDate date]
                           messageId:[DMMessage generateNewMessageId]
                            senderId:sender.userId
            ];
}

+ (DMMessage *)createWithImage:(UIImage *)image sender:(DMUser *)sender {
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    if (!imageData) {
        return nil;
    }
    
    return [DMMessage createWithType:kMessageTypeImage
                                body:[DMMessage imageSavedWithMessageId:[DMMessage generateNewMessageId] andData:imageData]
                            dateSent:[NSDate date]
                           messageId:[DMMessage generateNewMessageId]
                            senderId:sender.userId
            ];
}

+ (int64_t)generateNewMessageId {
    NSFetchRequest<DMMessage *> *fetchRequest = [DMMessage fetchRequest];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"messageId" ascending:NO]];
    fetchRequest.fetchLimit = 1;
    
    NSError *error = nil;
    NSArray<DMMessage *> *fetchedObjects = [[AppDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Error while fetching objects");
    }
    
    if (!fetchedObjects.count) {
        return 0;
    } else {
        NSLog(@"%lld", (fetchedObjects.firstObject.messageId + 1));
        return (fetchedObjects.firstObject.messageId + 1);
    }
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


@end
