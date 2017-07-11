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
#import "DMUser+CoreDataClass.h"

@implementation DMDecepticon

+ (void)insertDecepticonToCoreDataIfNeeded {
    
    NSString *fileName = @"DecepticonUser";
    NSDictionary *jsonDictionary = [DMUtility dictionaryFromJSONFileNamed:fileName];
    
    if (jsonDictionary) {
        [DMUser inserOrUpdateWithDictionary:jsonDictionary];
    }
    
}

@end
