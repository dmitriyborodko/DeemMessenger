//
//  DMAppDelegate.h
//  DeemMessenger
//
//  Created by ALS_Deem on 05/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "DMUser+CoreDataClass.h"

@interface DMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (DMAppDelegate *)sharedInstance;
+ (NSManagedObjectContext *)managedObjectContext;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (weak, nonatomic) DMUser *user;

- (void)saveContext;


@end
