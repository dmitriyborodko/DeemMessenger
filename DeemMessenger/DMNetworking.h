//
//  DMNetworking.h
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMMessage+CoreDataClass.h"
#import "DMDecepticon.h"

@interface DMNetworking : NSObject <DMDecepticonServing>

+ (DMNetworking *)sharedInstance;

- (void)getUsersWithCompletionHandler:(void (^)(void))blockName;
- (void)sendMessage:(NSDictionary *)messageDictionary completionHandler:(void (^)(BOOL success))completionHandler;

@end
