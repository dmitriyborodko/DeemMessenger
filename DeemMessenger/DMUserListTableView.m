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
#import "DMUser+CoreDataClass.h"

@interface DMUserListTableView () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic, readwrite) NSFetchedResultsController<DMUser *> *fetchedResultsController;

@end

@implementation DMUserListTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
#warning get user list
    
}

- (NSFetchedResultsController<DMUser *> *)fetchedResultsController {
    
    if (self.fetchedResultsController) {
        return self.fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([DMUser class]) inManagedObjectContext:[AppDelegate managedObjectContext]];
    fetchRequest.entity = entity;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isActive == %@", NO];
    fetchRequest.predicate = predicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateSent"
                                                                   ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    NSFetchedResultsController<DMUser *> *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[AppDelegate managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController = fetchedResultsController;
    self.fetchedResultsController.delegate = self;
    
    return fetchedResultsController;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
