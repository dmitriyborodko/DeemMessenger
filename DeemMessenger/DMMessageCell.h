//
//  DMMessageCell.h
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DMMessage+CoreDataClass.h"

@interface DMMessageCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightMargin;

- (void)setupWith:(DMMessage *)message;

@end
