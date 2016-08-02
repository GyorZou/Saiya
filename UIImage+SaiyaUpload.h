//
//  UIImage+SaiyaUpload.h
//  Saiya
//
//  Created by zougyor on 16/8/2.
//  Copyright © 2016年 crv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SaiyaUpload)
+(void)uploadImage:(UIImage*)image size:(CGSize)size blk:(void(^)(BOOL suc,NSData*dic))blk;
@end
