//
//  DMMessege+CoreDataProperties.m
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMMessege+CoreDataProperties.h"

@implementation DMMessege (CoreDataProperties)

+ (NSFetchRequest<DMMessege *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DMMessege"];
}

@dynamic body;
@dynamic dateSent;
@dynamic messageId;
@dynamic type;
@dynamic sender;

@end
