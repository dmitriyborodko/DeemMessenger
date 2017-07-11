//
//  DMChatVC.h
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMUser+CoreDataClass.h"

@interface DMChatVC : UITableViewController

@property (weak, nonatomic) DMUser *companion;

@end
