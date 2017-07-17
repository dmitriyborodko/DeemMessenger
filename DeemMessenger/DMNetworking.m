//
//  DMNetworking.m
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMNetworking.h"

@interface DMNetworking ()

@property (strong, nonatomic) dispatch_queue_t serialQueue;

@end

@implementation DMNetworking

@synthesize serialQueue = _serialQueue;

+ (DMNetworking *)sharedInstance {
    static DMNetworking *sharedInstance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        sharedInstance = [DMNetworking alloc];
        sharedInstance = [sharedInstance init];
    });
    
    return sharedInstance;
}

- (dispatch_queue_t)serialQueue {
    
    if (!_serialQueue) {
        _serialQueue  = dispatch_queue_create("com.networking.queue", DISPATCH_QUEUE_SERIAL);
    }
    return _serialQueue;
}

- (void)getUsersWithCompletionHandler:(void (^)(void))blockName {
    dispatch_async(self.serialQueue, ^{
        [DMDecepticon insertDecepticonToCoreDataIfNeeded];
        blockName();
    });
}

- (void)sendMessage:(NSDictionary *)messageDictionary completionHandler:(void (^)(BOOL success))completionHandler {
    dispatch_async(self.serialQueue, ^{
        [DMDecepticon handleEarthMessage:messageDictionary];
    });
    completionHandler(YES);
}

- (void)getDecepticonMessage:(NSDictionary *)dictionary {
    
    [DMMessage createFromWithEncodedData:[dictionary objectForKey:@"body"]
                                    type:[[dictionary objectForKey:@"type"] intValue]
                                dateSent:[NSDate date]
                                senderId:[DMDecepticon user].userId
                       compretionHandler:^(DMMessage *message) {
                           NSLog(@"Got from space: %@", message);
                       }];
}

@end
