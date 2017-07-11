//
//  DMNetworking.m
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMNetworking.h"

#import "DMDecepticon.h"

@implementation DMNetworking

+ (DMNetworking *)sharedInstance {
    static DMNetworking *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [DMNetworking alloc];
        sharedInstance = [sharedInstance init];
    });
    
    return sharedInstance;
}

- (void)getUsersWithCompletionHandler:(void (^)(void))blockName {
    [DMDecepticon insertDecepticonToCoreDataIfNeeded];
//    blockName
}

@end
