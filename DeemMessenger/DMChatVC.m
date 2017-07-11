//
//  DMChatVC.m
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMChatVC.h"

#import "DMDialogHolder.h"

#import "DMMessageCell.h"
#import "DMMessageCellFactory.h"

@interface DMChatVC () <UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UITextField *textInput;

@property (strong, nonatomic) DMDialogHolder *dialogHolder;

@end

@implementation DMChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dialogHolder = [[DMDialogHolder alloc] initWithCompanion:self.companion];
    self.title = self.companion.name;
    
    for (Class viewClass in [DMMessageCellFactory cellClasses]) {
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(viewClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(viewClass)];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dialogHolder.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DMMessage *message = self.dialogHolder.fetchedResultsController.fetchedObjects[indexPath.row];
    DMMessageCell *cell = [DMMessageCellFactory dequeueCellWithMessage:message forTableView:tableView];
    
    [cell setupWith:message];
    
    return cell;
}

#pragma mark - Controls

- (IBAction)optionsPressed:(id)sender {
    
}

- (IBAction)sendPressed:(id)sender {
    [self.dialogHolder sendTextMessage:self.textInput.text];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
