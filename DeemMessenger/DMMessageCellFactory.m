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
    // But what we can do - is to check this array to be equal to classes for messages.
    // This logic is more complex - much more efitient is to use #define for cellIdentifier and registerNibsForTableView . But this logic is more simple for development, and easy to refactor if we face real lag issues.
    return @[[DMMessageCell class], [DMTextMessageCell class], [DMImageMessageCell class], [DMGeolocationMessageCell class]];
}

+ (NSString *)nibNameForClass:(Class)class fromActiveUser:(BOOL)fromActive {
    NSString *postString = (fromActive ? @"Active" : @"Sender");
    return [NSStringFromClass(class) stringByAppendingString:postString];
}

+ (void)registerNibsForTableView:(UITableView *)tableView {
    for (Class class in [DMMessageCellFactory cellClasses]) {
        //Message from active user
        [tableView registerNib:[UINib nibWithNibName:[DMMessageCellFactory nibNameForClass:class fromActiveUser:YES]
                                              bundle:nil]
        forCellReuseIdentifier:[DMMessageCellFactory nibNameForClass:class fromActiveUser:YES]];
        
        //Message from sender
        [tableView registerNib:[UINib nibWithNibName:[DMMessageCellFactory nibNameForClass:class fromActiveUser:NO]
                                              bundle:nil]
        forCellReuseIdentifier:[DMMessageCellFactory nibNameForClass:class fromActiveUser:NO]];
    }
}

+ (DMMessageCell *)dequeueCellWithMessage:(DMMessage *)message forTableView:(UITableView *)tableView {
    
    NSString *cellIdentifier;
    
    switch (message.type) {
        case kMessageTypeText: {
            
            if (message.sender.isActive) {
                cellIdentifier = [DMMessageCellFactory nibNameForClass:[DMTextMessageCell class] fromActiveUser:YES];
            } else {
                cellIdentifier = [DMMessageCellFactory nibNameForClass:[DMTextMessageCell class] fromActiveUser:NO];
            }
            
            break;
        }
            
        case kMessageTypeImage: {
            
            if (message.sender.isActive) {
                cellIdentifier = [DMMessageCellFactory nibNameForClass:[DMImageMessageCell class] fromActiveUser:YES];
            } else {
                cellIdentifier = [DMMessageCellFactory nibNameForClass:[DMImageMessageCell class] fromActiveUser:NO];
            }
            
            break;
        }
            
        case kMessageTypeGeolocation: {
            
            if (message.sender.isActive) {
                cellIdentifier = [DMMessageCellFactory nibNameForClass:[DMGeolocationMessageCell class] fromActiveUser:YES];
            } else {
                cellIdentifier = [DMMessageCellFactory nibNameForClass:[DMGeolocationMessageCell class] fromActiveUser:NO];
            }
            
            break;
        }
            
        default: {
            
            if (message.sender.isActive) {
                cellIdentifier = [DMMessageCellFactory nibNameForClass:[DMMessageCell class] fromActiveUser:YES];
            } else {
                cellIdentifier = [DMMessageCellFactory nibNameForClass:[DMMessageCell class] fromActiveUser:NO];
            }
            
            NSLog(@"Unknown message cell type!");
            break;
        }
    }
    
    return [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
}

+ (CGFloat)estimatedHeightForCellWithMessage:(DMMessage *)message forScreenWidth:(CGFloat)screenWidth {
    switch (message.type) {
        case kMessageTypeText: {
            return 50;
            break;
        }
            
        case kMessageTypeImage: {
            return 150;
            break;
        }
            
        case kMessageTypeGeolocation: {
            return 300;
            break;
        }
            
        default: {
            return 50;
            break;
        }
    }
}

@end
