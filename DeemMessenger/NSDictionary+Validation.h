//
//  NSDictionary+Validation.h
//  DeemMessenger
//
//  Created by ALS_Deem on 11/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Validation)

- (BOOL)isValidValueForKey:(NSString *)key;
- (void)ifValidValueForKey:(NSString *)key perform:(void (^)(NSString *object))successBlock;

@end
