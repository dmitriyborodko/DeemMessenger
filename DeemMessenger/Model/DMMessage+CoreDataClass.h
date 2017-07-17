//
//  DMMessage+CoreDataClass.h
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

typedef enum : int16_t {
    kMessageTypeText        = 0,
    kMessageTypeImage       = 1,
    kMessageTypeGeolocation = 2
} DMMessageType;

@class DMUser;

NS_ASSUME_NONNULL_BEGIN

@interface DMMessage : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "DMMessage+CoreDataProperties.h"

@interface DMMessage ()

@property (nonatomic) DMMessageType type;

+ (DMMessage *)createFromWithEncodedData:(NSData *)body
                                    type:(DMMessageType)type
                                dateSent:(NSDate *)dateSent
                               messageId:(int16_t)messageId
                                senderId:(int16_t)senderId;

+ (DMMessage *)createWithText:(NSString *)string sender:(DMUser *)sender;
+ (DMMessage *)createWithImage:(UIImage *)image sender:(DMUser *)sender;

+ (int64_t)generateNewMessageId;

- (NSDictionary *)map;

@end
