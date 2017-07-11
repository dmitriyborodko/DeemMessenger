//
//  DMUserListVC.m
//  DeemMessenger
//
//  Created by ALS_Deem on 11/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMUserListVC.h"
#import "DMNetworking.h"
#import "DMUserListTableView.h"

#import "DMChatVC.h"

@interface DMUserListVC ()

@property (weak, nonatomic) IBOutlet DMUserListTableView *tableView;

@end

@implementation DMUserListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        [[DMNetworking sharedInstance] getUsersWithCompletionHandler:^{
            NSLog(@"Users loaded");
        }];
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *selectedIndex = [self.tableView indexPathForCell:(UITableViewCell *)sender];
    DMUser *selectedUser = self.tableView.fetchedResultsController.fetchedObjects[selectedIndex.row];
    
    ((DMChatVC *)segue.destinationViewController).companion = selectedUser;
}

@end
