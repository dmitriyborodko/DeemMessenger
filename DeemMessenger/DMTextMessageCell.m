//
//  DMTextMessageCell.m
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMTextMessageCell.h"

@interface DMTextMessageCell ()

@property (weak, nonatomic) IBOutlet UILabel *textMessage;

@end

@implementation DMTextMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupWith:(DMMessage *)message {
    [super setupWith:message];
    
    self.textMessage.text = message.body;
}

@end
