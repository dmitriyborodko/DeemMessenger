//
//  AppDelegate.h
//  DeemMessenger
//
//  Created by ALS_Deem on 05/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)sharedInstance;
+ (NSManagedObjectContext *)managedObjectContext;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end
