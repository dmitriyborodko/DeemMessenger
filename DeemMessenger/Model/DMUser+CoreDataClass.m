//
//  DMUser+CoreDataClass.m
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMUser+CoreDataClass.h"
#import "DMMessage+CoreDataClass.h"

#import "DMAppDelegate.h"

#import "NSDictionary+Validation.h"
#import "DMUtility.h"

@implementation DMUser

+ (DMUser *)active {
    
    if ([DMAppDelegate sharedInstance].user) {
        return [DMAppDelegate sharedInstance].user;
    }
    
    __block DMUser *user = nil;
    
    [[DMAppDelegate managedObjectContext] performBlockAndWait:^{
        
        if ([DMAppDelegate sharedInstance].user) {
            user = [DMAppDelegate sharedInstance].user;
        } else {
            NSFetchRequest *fetchRequest = [DMUser fetchRequest];
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"isActive == %d", YES];
            
            NSError *error = nil;
            NSArray *fetchedObjects = [[DMAppDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error];
            
            if (fetchedObjects.count) {
                user = [fetchedObjects firstObject];
            }
            else {
                NSDictionary *userJSON = [DMUtility dictionaryFromJSONFileNamed:@"ActiveUser"];
                user = [DMUser inserOrUpdateWithDictionary:userJSON];
            }
            
            [DMAppDelegate sharedInstance].user = user;
        }
    }];
    
    return user;
}

+ (DMUser *)inserOrUpdateWithDictionary:(NSDictionary *)dictionary {
    
    __block DMUser *user = nil;
    
    [[DMAppDelegate managedObjectContext] performBlockAndWait:^{
        user = [self insertOrUpdateWithDictionaryUnsafe:dictionary];
    }];
    
    return user;
}

+ (DMUser *)insertOrUpdateWithDictionaryUnsafe:(NSDictionary *)dictionary {
    
    __block DMUser *user = nil;
    
    [dictionary ifValidValueForKey:@"id" perform:^(id object) {
        int userId = [object intValue];
        
        NSFetchRequest *fetchRequest = [DMUser fetchRequest];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userId == %d", userId];
        
        NSError *error = nil;
        NSArray *fetchedObjects = [[DMAppDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error];
        
        if (fetchedObjects.count) {
            DMUser *foundUser = [fetchedObjects firstObject];
            user = foundUser;
        }
        
        else {
            NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([DMUser class]) inManagedObjectContext:[DMAppDelegate managedObjectContext]];
            user = [[DMUser alloc] initWithEntity:entity insertIntoManagedObjectContext:[DMAppDelegate managedObjectContext]];
            user.userId = [object intValue];
        }
        
        [dictionary ifValidValueForKey:@"name" perform:^(NSString *object) {
            user.name = object;
        }];
        
        [dictionary ifValidValueForKey:@"isActive" perform:^(NSString *object) {
            user.isActive = [object boolValue];
        }];
        
        NSLog(@"%lu", user.messages.count);
        
        [[DMAppDelegate managedObjectContext] save:&error];
        
    }];
    
    return user;
}

+ (DMUser *)withId:(int64_t)userId {
    NSFetchRequest<DMUser *> *fetchRequest = [DMUser fetchRequest];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"userId" ascending:NO]];
    fetchRequest.fetchLimit = 1;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"userId == %d", userId];
    
    NSError *error = nil;
    NSArray<DMUser *> *fetchedObjects = [[DMAppDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Error while fetching objects");
    }
    
    if (!fetchedObjects.count) {
        return nil;
    } else {
        return fetchedObjects.firstObject;
    }
}



@end
