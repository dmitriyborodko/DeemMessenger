//
//  DMUtility.h
//  DeemMessenger
//
//  Created by ALS_Deem on 11/07/2017.
//  Copyright © 2017 wrk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DMUser+CoreDataClass.h"

@interface DMUtility : NSObject

+ (NSDictionary *)dictionaryFromJSONFileNamed:(NSString *)fileName;
+ (NSString *)pathForImageWithName:(NSString *)imageName;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
