//
//  DMUser+CoreDataProperties.h
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DMUser (CoreDataProperties)

+ (NSFetchRequest<DMUser *> *)fetchRequest;

@property (nonatomic) int64_t userId;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) BOOL isActiveUser;
@property (nullable, nonatomic, retain) NSSet<DMMessege *> *messages;

@end

@interface DMUser (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(DMMessege *)value;
- (void)removeMessagesObject:(DMMessege *)value;
- (void)addMessages:(NSSet<DMMessege *> *)values;
- (void)removeMessages:(NSSet<DMMessege *> *)values;

@end

NS_ASSUME_NONNULL_END
