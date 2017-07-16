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

@property (retain, nonatomic, readwrite) NSFetchedResultsController *fetchedResultsController;

@end

@implementation DMUserListTableView

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    self.delegate = self;
    self.dataSource = self;
    self.fetchedResultsController.delegate = self;
}

- (NSFetchedResultsController<DMUser *> *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    return [self newFetchedResultsController];
}

- (NSFetchedResultsController<DMUser *> *)newFetchedResultsController {
    NSFetchRequest *fetchRequest = [DMUser fetchRequest];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isActive == %d", NO];
    fetchRequest.predicate = predicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                                   ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    NSFetchedResultsController<DMUser *> *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[AppDelegate managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController = fetchedResultsController;
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

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationTop];
            break;
        }
            
            
        default:
            break;
    }
}

@end
