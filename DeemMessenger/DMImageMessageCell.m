//
//  DMImageMessageCell.m
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMImageMessageCell.h"

@interface DMImageMessageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageMessage;

@end

@implementation DMImageMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupWith:(DMMessage *)message {
    [super setupWith:message];
    
    self.imageMessage.image = nil;
    
//    dispatch_async(dispatch_get_global_queue( DI4SPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
//        
//        NSString *text = [[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding];
//        
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//            
//            self.textMessage.text = text;
//            
//        });
//        
//    });
}

@end
