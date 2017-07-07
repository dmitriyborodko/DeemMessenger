//
//  DMMessageView.h
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMMessage.h"

@interface DMMessageView : UIView

- (instancetype)initWithMessage:(DMMessage *)message;

- (CGFloat)estimatedHeightForMessage:(DMMessage *)message;

@end
