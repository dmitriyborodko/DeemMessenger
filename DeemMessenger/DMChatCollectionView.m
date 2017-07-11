//
//  DMChatCollectionView.m
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMChatCollectionView.h"

#import "DMMessageCell.h"
#import "DMMessageCellFactory.h"

@interface DMChatCollectionView () <UICollectionViewDataSource, DMDialogHolderDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation DMChatCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dialogHolder.delegate = self;
    self.delegate = self;
    self.dataSource = self;
    
    for (Class viewClass in [DMMessageCellFactory cellClasses]) {
        [self registerNib:[UINib nibWithNibName:NSStringFromClass(viewClass) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(viewClass)];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dialogHolder.fetchedResultsController.fetchedObjects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DMMessage *message = self.dialogHolder.fetchedResultsController.fetchedObjects[indexPath.row];
    DMMessageCell *cell = [DMMessageCellFactory dequeueCellWithMessage:message forCollectionView:collectionView atIndexPath:indexPath];
    
    [cell setupWith:message];
    
    return cell;
}

@end
