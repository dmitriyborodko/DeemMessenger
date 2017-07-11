//
//  DMChatCollectionView.h
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DMDialogHolder.h"

@interface DMChatCollectionView : UICollectionView

@property (strong, nonatomic) DMDialogHolder *dialogHolder;

@end
