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

+ (void)registerNibsForTableView:(UITableView *)tableView;
+ (DMMessageCell *)dequeueCellWithMessage:(DMMessage *)message forTableView:(UITableView *)tableView;
+ (CGFloat)estimatedHeightForCellWithMessage:(DMMessage *)message forScreenWidth:(CGFloat)screenWidth;

@end
