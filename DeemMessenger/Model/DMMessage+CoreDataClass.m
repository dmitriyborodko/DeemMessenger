//
//  DMMessage+CoreDataClass.m
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMMessage+CoreDataClass.h"
#import "DMUser+CoreDataClass.h"
#import "AppDelegate.h"

@implementation DMMessage

@dynamic type;

+ (DMMessage *)createWithType:(DMMessageType)type
                         body:(NSData *)body
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

+ (DMMessage *)createWithText:(NSString *)string sender:(DMUser *)sender {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [DMMessage createWithType:kMessageTypeText
                                body:data
                            dateSent:[NSDate date]
                           messageId:[DMMessage generateNewMessageId]
                            senderId:sender.userId
            ];
}

+ (DMMessage *)createWithImage:(UIImage *)image sender:(DMUser *)sender {
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    return [DMMessage createWithType:kMessageTypeImage
                                body:data
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
        return fetchedObjects.firstObject.messageId;
    }
}

- (NSDictionary *)map {
    NSMutableDictionary *messageDictionary = [NSMutableDictionary new];
    
    [messageDictionary setObject:[NSString stringWithFormat:@"%d", self.type] forKey:@"type"];
    [messageDictionary setObject:self.body forKey:@"body"];
    [messageDictionary setObject:self.dateSent forKey:@"dateSent"];
    [messageDictionary setObject:[NSString stringWithFormat:@"%lld", self.messageId] forKey:@"messageId"];
    [messageDictionary setObject:[NSString stringWithFormat:@"%lld", self.sender.userId] forKey:@"senderId"];
    
    return [NSDictionary dictionaryWithDictionary:messageDictionary];
}


@end
