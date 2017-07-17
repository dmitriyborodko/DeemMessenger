//
//  DMMessage+CoreDataClass.h
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <Foundation/Foundation.h>
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
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface DMMessage ()

@property (nonatomic) DMMessageType type;

+ (void)createFromWithEncodedData:(NSData *)body
                             type:(DMMessageType)type
                         dateSent:(NSDate *)dateSent
                         senderId:(int16_t)senderId
                compretionHandler:(void(^)(DMMessage *message))completionHandler;

+ (void)createWithText:(NSString *)string
                sender:(DMUser *)sender
     compretionHandler:(void(^)(DMMessage *message))completionHandler;

+ (void)createWithImage:(UIImage *)image
                 sender:(DMUser *)sender
      compretionHandler:(void(^)(DMMessage *message))completionHandler;

+ (void)createWithCoordinate:(CLLocationCoordinate2D)coordinate
                      sender:(DMUser *)sender
           compretionHandler:(void(^)(DMMessage *message))completionHandler;

- (NSDictionary *)map;

@end
