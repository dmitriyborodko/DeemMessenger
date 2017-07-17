//
//  DMDecepticon.m
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMDecepticon.h"
#import "AppDelegate.h"
#import "DMUtility.h"
#import "DMNetworking.h"

@implementation DMDecepticon

+ (DMUser *)insertDecepticonToCoreDataIfNeeded {
    
    NSString *fileName = @"DecepticonUser";
    NSDictionary *jsonDictionary = [DMUtility dictionaryFromJSONFileNamed:fileName];
    
    if (jsonDictionary) {
        return [DMUser inserOrUpdateWithDictionary:jsonDictionary];
    } else {
        return nil;
    }
    
}

+ (DMUser *)user {
    __block DMUser *user;
    
    [[AppDelegate managedObjectContext] performBlockAndWait:^{
        NSFetchRequest *fetchRequest = [DMUser fetchRequest];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userId == %d", 2];
        NSError *error;
        NSArray *decepticons = [fetchRequest execute:&error];
        if (decepticons.count) {
            user = decepticons.firstObject;
        } else {
            user = nil;
        }
    }];
    
    return user;
    
    
}

+ (void)handleEarthMessage:(NSDictionary *)dictionary {
    int delay = [DMDecepticon getRandomIntBetween:1 to:3];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [[DMNetworking sharedInstance] getDecepticonMessage:dictionary];
        });
    });
    
    
}

+ (int)getRandomIntBetween:(int)from to:(int)to {
    return (int)from + arc4random() % (to-from+1);
}

@end
