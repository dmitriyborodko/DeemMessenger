//
//  DMUtility.m
//  DeemMessenger
//
//  Created by ALS_Deem on 11/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMUtility.h"

@implementation DMUtility

+ (NSDictionary *)dictionaryFromJSONFileNamed:(NSString *)fileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];

    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    if (!jsonString) {
        NSLog(@"File couldn't be read!");
        return nil;
    }
    NSError *jsonError;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonError];
    
    if (jsonError) {
        NSLog(@"Couldn't read json form Decepticon file");
        return nil;
    } else {
        return [NSDictionary dictionaryWithDictionary:jsonDict];
    }
}

+ (NSString *)pathForImageWithName:(NSString *)imageName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *docs = [paths objectAtIndex:0];
    return  [docs stringByAppendingFormat:@"/%@", imageName];
}

@end
