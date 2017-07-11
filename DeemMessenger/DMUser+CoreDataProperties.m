//
//  DMUser+CoreDataProperties.m
//  DeemMessenger
//
//  Created by ALS_Deem on 11/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMUser+CoreDataProperties.h"

@implementation DMUser (CoreDataProperties)

+ (NSFetchRequest<DMUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DMUser"];
}

@dynamic isActive;
@dynamic name;
@dynamic userId;
@dynamic messages;

@end
