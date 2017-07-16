//
//  DMDialogHolder.h
//  DeemMessenger
//
//  Created by ALS_Deem on 07/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMUser+CoreDataClass.h"
#import "DMMessage+CoreDataClass.h"

#import <UIKit/UIKit.h>

@protocol DMDialogHolderDelegate <NSObject>

@required

- (void)messageSent;
- (void)insertObjectForIndexPath:(NSIndexPath *)indexPath;

@end

@interface DMDialogHolder : NSObject

@property (weak, nonatomic) DMUser *companion;
@property (retain, nonatomic, readwrite) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) id <DMDialogHolderDelegate> delegate;

- (instancetype)initWithCompanion:(DMUser *)companion;

- (void)sendTextMessage:(NSString *)text;
- (void)sendImageMessage:(UIImage *)image;
- (void)sendGeolocationMessage;

@end
