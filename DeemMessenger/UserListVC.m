//
//  UserListVC.m
//  DeemMessenger
//
//  Created by ALS_Deem on 11/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "UserListVC.h"
#import "DMNetworking.h"

@interface UserListVC ()

@end

@implementation UserListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //Background Thread
        
        
        [[DMNetworking sharedInstance] getUsersWithCompletionHandler:^{
            <#code#>
        }];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"%@", sender);
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
