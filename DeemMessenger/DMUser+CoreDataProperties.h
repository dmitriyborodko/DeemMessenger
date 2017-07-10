//
//  DMUser+CoreDataProperties.h
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DMUser (CoreDataProperties)

+ (NSFetchRequest<DMUser *> *)fetchRequest;

@property (nonatomic) BOOL isActiveUser;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int64_t userId;
@property (nullable, nonatomic, retain) NSSet<DMMessage *> *messages;

@end

@interface DMUser (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(DMMessage *)value;
- (void)removeMessagesObject:(DMMessage *)value;
- (void)addMessages:(NSSet<DMMessage *> *)values;
- (void)removeMessages:(NSSet<DMMessage *> *)values;

@end

NS_ASSUME_NONNULL_END
