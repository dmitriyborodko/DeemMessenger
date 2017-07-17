//
//  DMDecepticon.h
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMUser+CoreDataClass.h"

@protocol DMDecepticonServing <NSObject>

@required

- (void)getDecepticonMessage:(NSDictionary *)dictionary;

@end

@interface DMDecepticon : NSObject

+ (DMUser *)insertDecepticonToCoreDataIfNeeded;
+ (DMUser *)user;
+ (void)handleEarthMessage:(NSDictionary *)dictionary;

@end
