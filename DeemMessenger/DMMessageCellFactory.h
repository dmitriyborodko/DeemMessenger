//
//  DMMessageCellFactory.h
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DMMessage+CoreDataClass.h"
#import "DMMessageCell.h"

@interface DMMessageCellFactory : NSObject

+ (NSArray *)cellClasses;
+ (DMMessageCell *)dequeueCellWithMessage:(DMMessage *)message forTableView:(UITableView *)tableView;
+ (CGSize)estimatedContentSizeOfMessage:(DMMessage *)message forScreenWidth:(CGFloat)screenWidth;

@end
