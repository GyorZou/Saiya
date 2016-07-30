//
//  UIImage+MLImageForBundle.m
//  ewj
//
//  Created by WenYang on 15/10/27.
//  Copyright © 2015年 cre.crv.ewj. All rights reserved.
//



#import "UIImage+MLBrowserPhotoImageForBundle.h"

@implementation UIImage (MLBrowserPhotoImageForBundle)
+ (instancetype)ml_imageFromBundleNamed:(NSString *)name{
    return [UIImage imageNamed:[@"MLPhotoBrowser.bundle" stringByAppendingPathComponent:name]];
}
@end
