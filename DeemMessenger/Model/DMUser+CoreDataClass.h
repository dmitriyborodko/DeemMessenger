//
//  DMUser+CoreDataClass.h
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DMMessage;

NS_ASSUME_NONNULL_BEGIN

@interface DMUser : NSManagedObject

+ (DMUser *)active;
+ (DMUser *)inserOrUpdateWithDictionary:(NSDictionary *)dictionary;
+ (DMUser *)withId:(int64_t)userId;

@end

NS_ASSUME_NONNULL_END

#import "DMUser+CoreDataProperties.h"
