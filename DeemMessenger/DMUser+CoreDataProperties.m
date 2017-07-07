//
//  DMUser+CoreDataProperties.m
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMUser+CoreDataProperties.h"

@implementation DMUser (CoreDataProperties)

+ (NSFetchRequest<DMUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DMUser"];
}

@dynamic userId;
@dynamic name;
@dynamic isActiveUser;
@dynamic messages;

@end
