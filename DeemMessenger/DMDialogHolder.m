//
//  DMDialogHolder.m
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMDialogHolder.h"
#import "AppDelegate.h"

#import "DMNetworking.h"

@interface DMDialogHolder () <NSFetchedResultsControllerDelegate>

@end

@implementation DMDialogHolder

@synthesize fetchedResultsController = _fetchedResultsController;

- (instancetype)initWithCompanion:(DMUser *)companion {
    if (self = [super init]) {
        self.companion = companion;
        
        NSError *error = nil;
        if (![[self fetchedResultsController] performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    return self;
}

#pragma mark - Fetched Results Controller

- (NSFetchedResultsController<DMMessage *> *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    return [self newFetchedResultsController];
}

- (NSFetchedResultsController<DMMessage *> *)newFetchedResultsController {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([DMMessage class]) inManagedObjectContext:[AppDelegate managedObjectContext]];
    fetchRequest.entity = entity;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateSent"
                                                                   ascending:NO];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    NSFetchedResultsController<DMMessage *> *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[AppDelegate managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController = fetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.delegate insertObjectForIndexPath:newIndexPath];
            break;
        }
            
            
        default:
            break;
    }
}

#pragma mark - Actions

- (void)sendTextMessage:(NSString *)text {
    
    if (!text.length) {
        return;
    }
    
    DMMessage *message = [DMMessage createWithText:text sender:[DMUser active]];
    
    [[DMNetworking sharedInstance] sendMessage:[message map] completionHandler:^(BOOL success) {
        if (success) {
            [self.delegate messageSent];
        }
    }];
}

- (void)sendImageMessage:(UIImage *)image {
    if (!image) {
        return;
    }
    
    DMMessage *message = [DMMessage createWithImage:image sender:[DMUser active]];
    
    [[DMNetworking sharedInstance] sendMessage:[message map] completionHandler:^(BOOL success) {
        if (success) {
            [self.delegate messageSent];
        }
    }];
}




@end
