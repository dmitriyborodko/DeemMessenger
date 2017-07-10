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

- (instancetype)initWithCompanion:(DMUser *)companion {
    if (self = [super init]) {
        self.companion = companion;
    }
    return self;
}

#pragma mark - Fetched Results Controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (self.fetchedResultsController) {
        return self.fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([DMMessage class]) inManagedObjectContext:[AppDelegate managedObjectContext]];
    fetchRequest.entity = entity;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sender == %@", self.companion];
    fetchRequest.predicate = predicate;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateSent"
                                                                   ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[AppDelegate managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController = fetchedResultsController;
    self.fetchedResultsController.delegate = self;
    
    return fetchedResultsController;
}

#pragma  mark - Dialog Holder Delegate



@end
