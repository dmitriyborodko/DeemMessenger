//
//  DMDialogHolder.m
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMDialogHolder.h"
#import "AppDelegate.h"

@interface DMDialogHolder () <NSFetchedResultsControllerDelegate>

@property (weak, nonatomic, readwrite) NSFetchedResultsController *fetchedResultsController;

@end

@implementation DMDialogHolder

@synthesize fetchedResultsController = _fetchedResultsController;

- (instancetype)initWithCompanion:(DMUser *)companion {
    if (self = [super init]) {
        self.companion = companion;
    }
    return self;
}

#pragma mark - Fetched Results Controller

- (NSFetchedResultsController<DMMessage *> *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([DMMessage class]) inManagedObjectContext:[AppDelegate managedObjectContext]];
    fetchRequest.entity = entity;
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sender == %@", self.companion];
//    fetchRequest.predicate = predicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateSent"
                                                                   ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    NSFetchedResultsController<DMMessage *> *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[AppDelegate managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    _fetchedResultsController = fetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

#pragma  mark - Dialog Holder Delegate



@end
