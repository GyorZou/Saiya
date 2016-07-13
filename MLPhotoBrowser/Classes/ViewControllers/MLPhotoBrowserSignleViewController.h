//
//  MLPhotoBrowserSignleViewController.h
//  ewj
//
//  Created by WenYang on 15/10/27.
//  Copyright © 2015年 cre.crv.ewj. All rights reserved.
//


#import "MLPhotoBrowserViewController.h"

@interface MLPhotoBrowserSignleViewController : MLPhotoBrowserViewController
// 放大缩小一张图片的情况下（查看头像）
- (void)showHeadPortrait:(UIImageView *)toImageView;
// 放大缩小一张图片的情况下（查看头像）/ 缩略图是toImageView.image 原图URL
- (void)showHeadPortrait:(UIImageView *)toImageView originUrl:(NSString *)originUrl;
@end
