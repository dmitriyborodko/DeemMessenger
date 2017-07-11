//
//  DMMessageCellFactory.m
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMMessageCellFactory.h"

#import "DMTextMessageCell.h"
#import "DMImageMessageCell.h"
#import "DMGeolocationMessageCell.h"

@implementation DMMessageCellFactory

+ (NSArray *)cellClasses {
    // It is possible to get subsclasses in runtime, but this is not safe - if we add some class accidently we may catch hard to be found error.
    // But what we can do - is to check this array to be equal to
    return @[[DMMessageCell class], [DMTextMessageCell class], [DMImageMessageCell class], [DMGeolocationMessageCell class]];
}

+ (DMMessageCell *)dequeueCellWithMessage:(DMMessage *)message forCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    
    Class cellClass;
    
    switch (message.type) {
        case kMessageTypeText: {
            cellClass = [DMTextMessageCell class];
            break;
        }
            
        case kMessageTypeImage: {
            cellClass = [DMImageMessageCell class];
            break;
        }
            
        case kMessageTypeGeolocation: {
            cellClass = [DMGeolocationMessageCell class];
            break;
        }
            
        default: {
            cellClass = [DMMessageCell class];
            NSLog(@"Unknown message cell type!");
            break;
        }
    }
    
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
}

+ (CGSize)estimatedContentSizeOfMessage:(DMMessage *)message forScreenWidth:(CGFloat)screenWidth {
    switch (message.type) {
        case kMessageTypeText: {
            return CGSizeMake(screenWidth, 50);
            break;
        }
            
        case kMessageTypeImage: {
            return CGSizeMake(screenWidth, 50);
            break;
        }
            
        case kMessageTypeGeolocation: {
            return CGSizeMake(screenWidth, 50);
            break;
        }
            
        default: {
            return CGSizeMake(screenWidth, 50);
//            NSLog(@"Unknown message cell type!");
            break;
        }
    }
}

@end
