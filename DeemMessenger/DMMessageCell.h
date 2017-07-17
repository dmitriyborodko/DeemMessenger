//
//  DMMessageCell.h
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DMMessage+CoreDataClass.h"
#import "DMUser+CoreDataClass.h"

@interface DMMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *margin;
@property (weak, nonatomic) IBOutlet UILabel *activeObject;

- (void)setupWith:(DMMessage *)message;

@end
