//
//  DMMessege+CoreDataProperties.h
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMMessege+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DMMessege (CoreDataProperties)

+ (NSFetchRequest<DMMessege *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *body;
@property (nullable, nonatomic, copy) NSDate *dateSent;
@property (nonatomic) int64_t messageId;
@property (nonatomic) int16_t type;
@property (nullable, nonatomic, retain) DMUser *sender;

@end

NS_ASSUME_NONNULL_END
