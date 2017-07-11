//
//  DMMessage+CoreDataProperties.m
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMMessage+CoreDataProperties.h"

@implementation DMMessage (CoreDataProperties)

+ (NSFetchRequest<DMMessage *> *)fetchRequest {
    return [[NSFetchRequest alloc] initWithEntityName:@"DMMessage"];
}

@dynamic body;
@dynamic dateSent;
@dynamic messageId;
@dynamic type;
@dynamic sender;

@end
