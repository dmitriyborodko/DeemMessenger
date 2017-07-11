//
//  DMTextMessageCell.m
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMTextMessageCell.h"

@implementation DMTextMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupWith:(DMMessage *)message {
    [super setupWith:message];
    
    
    NSString *text = [[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding];

    
    self.textLabel.text = text;
}

@end
