//
//  DMUser+CoreDataClass.m
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMUser+CoreDataClass.h"
#import "DMMessage+CoreDataClass.h"

#import "AppDelegate.h"

#import "NSDictionary+Validation.h"
#import "DMUtility.h"

@implementation DMUser

+ (DMUser *)active {
    
    if ([AppDelegate sharedInstance].user) {
        return [AppDelegate sharedInstance].user;
    }
    
    __block DMUser *user = nil;
    
    [[AppDelegate managedObjectContext] performBlockAndWait:^{
        
        if ([AppDelegate sharedInstance].user) {
            user = [AppDelegate sharedInstance].user;
        } else {
            NSFetchRequest *fetchRequest = [DMUser fetchRequest];
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"isActive == %@", YES];
            
            NSError *error = nil;
            NSArray *fetchedObjects = [[AppDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error];
            
            if (fetchedObjects.count) {
                user = [fetchedObjects firstObject];
            }
            else {
                NSDictionary *userJSON = [DMUtility dictionaryFromJSONFileNamed:@"ActiveUser.json"];
                user = [DMUser inserOrUpdateWithDictionary:userJSON];
            }
            
            [AppDelegate sharedInstance].user = user;
        }
    }];
    
    return user;
}

+ (DMUser *)inserOrUpdateWithDictionary:(NSDictionary *)dictionary {
    
    __block DMUser *user = nil;
    
    [[AppDelegate managedObjectContext] performBlockAndWait:^{
        user = [self insertOrUpdateWithDictionaryUnsafe:dictionary];
    }];
    
    return user;
}

+ (DMUser *)insertOrUpdateWithDictionaryUnsafe:(NSDictionary *)dictionary {
    
    __block DMUser *user = nil;
    
    [dictionary ifValidValueForKey:@"id" perform:^(id object) {
        int16_t userId = [object integerValue];
        
        NSFetchRequest *fetchRequest = [DMUser fetchRequest];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userId == %@", userId];
        
        NSError *error = nil;
        NSArray *fetchedObjects = [[AppDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error];
        if (fetchedObjects.count) {
            DMUser *foundUser = [fetchedObjects firstObject];
            
            [dictionary ifValidValueForKey:@"name" perform:^(NSString *object) {
                foundUser.name = object;
            }];
            
            [dictionary ifValidValueForKey:@"isActive" perform:^(NSString *object) {
                foundUser.isActive = [object boolValue];
            }];
            
            user = foundUser;
        }
        else {
            NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([DMUser class]) inManagedObjectContext:[AppDelegate managedObjectContext]];
            user = [[DMUser alloc] initWithEntity:entity insertIntoManagedObjectContext:[AppDelegate managedObjectContext]];
        }
    }];
    
    return user;
}



@end
