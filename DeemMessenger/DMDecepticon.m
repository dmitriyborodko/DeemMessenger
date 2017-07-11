//
//  DMDecepticon.m
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMDecepticon.h"
#import "AppDelegate.h"

@implementation DMDecepticon

+ (void)insertDecepticonToCoreDataIfNeeded {
    NSString *fileName = @"DecepticonUser.json";
    NSURL *documentsFolderURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSString *filePath = [documentsFolderURL.path stringByAppendingString:fileName];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *jsonError;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonError];
    if (jsonError) {
        NSLog(@"Couldn't read json form Decepticon file");
    } else {
        [DMUser inserOrUpdateWithDictionary:jsonDict];
    }
}

@end
