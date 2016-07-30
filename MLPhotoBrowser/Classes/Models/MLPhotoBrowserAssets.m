//
//  MLPhotoBrowserAssets.m
//  ewj
//
//  Created by WenYang on 15/10/27.
//  Copyright © 2015年 cre.crv.ewj. All rights reserved.
//


#import "MLPhotoBrowserAssets.h"

@implementation MLPhotoBrowserAssets

- (UIImage *)thumbImage{
    return [UIImage imageWithCGImage:[self.asset thumbnail]];
}

- (UIImage *)originImage{
    return [UIImage imageWithCGImage:[[self.asset defaultRepresentation] fullScreenImage]];
}

- (BOOL)isVideoType{
    NSString *type = [self.asset valueForProperty:ALAssetPropertyType];
    //媒体类型是视频
    return [type isEqualToString:ALAssetTypeVideo];
}

@end
