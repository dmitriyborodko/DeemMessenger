//
//  UserListTableView.h
//  DeemMessenger
//
//  Created by ALS_Deem on 11/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMUser+CoreDataClass.h"

@interface DMUserListTableView : UITableView

@property (retain, nonatomic, readonly) NSFetchedResultsController<DMUser *> *fetchedResultsController;

@end
