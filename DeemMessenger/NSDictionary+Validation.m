//
//  NSDictionary+Validation.m
//  DeemMessenger
//
//  Created by ALS_Deem on 11/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "NSDictionary+Validation.h"

@implementation NSDictionary (Validation)

- (BOOL)isValidValueForKey:(NSString *)key {
    return ([self objectForKey:key] && ![[self objectForKey:key] isKindOfClass:[NSNull class]]);
}

- (void)ifValidValueForKey:(NSString *)key perform:(void (^)(NSString *object))successBlock {
    if ([self objectForKey:key] && ![[self objectForKey:key] isKindOfClass:[NSNull class]]) {
        successBlock([NSString stringWithFormat:@"%@", [[self objectForKey:key] copy]]);
    }
}

@end
