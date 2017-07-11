//
//  UserListTableView.m
//  DeemMessenger
//
//  Created by ALS_Deem on 11/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMUserListTableView.h"
#import "AppDelegate.h"
#import "DMDecepticon.h"

@interface DMUserListTableView () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic, readwrite) NSFetchedResultsController<DMUser *> *fetchedResultsController;

@end

@implementation DMUserListTableView

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    self.fetchedResultsController.delegate = self;
}

- (NSFetchedResultsController<DMUser *> *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [DMUser fetchRequest];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isActive == %d", NO];
    fetchRequest.predicate = predicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                                   ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    NSFetchedResultsController<DMUser *> *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[AppDelegate managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    _fetchedResultsController = fetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    
    cell.textLabel.text = self.fetchedResultsController.fetchedObjects[indexPath.row].name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
