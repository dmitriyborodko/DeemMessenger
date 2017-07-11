//
//  DMMessage+CoreDataProperties.h
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMMessage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DMMessage (CoreDataProperties)

+ (NSFetchRequest<DMMessage *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *body;
@property (nullable, nonatomic, copy) NSDate *dateSent;
@property (nonatomic) int64_t messageId;
@property (nonatomic) int16_t type;
@property (nullable, nonatomic, retain) DMUser *sender;

@end

NS_ASSUME_NONNULL_END
