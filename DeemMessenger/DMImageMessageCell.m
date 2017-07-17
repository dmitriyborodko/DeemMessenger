//
//  DMImageMessageCell.m
//  DeemMessenger
//
//  Created by ALS_Deem on 10/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import "DMImageMessageCell.h"
#import "DMUtility.h"

@interface DMImageMessageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *activeObject;

@end

@implementation DMImageMessageCell

@synthesize activeObject = _imageMessage;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupWith:(DMMessage *)message {
    [super setupWith:message];
    
    _imageMessage.image = nil;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        if (message.body) {
            NSString *path = [DMUtility pathForImageWithName:message.body];
            CGFloat imageMessageSide = MIN(_imageMessage.frame.size.width, _imageMessage.frame.size.height);
            UIImage *image = [DMUtility imageWithImage:[UIImage imageWithContentsOfFile:path]
                                          scaledToSize:CGSizeMake(imageMessageSide, imageMessageSide)];
            
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    _imageMessage.image = image;
                });
            }
        }
        
    });
}

@end
