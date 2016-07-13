//
//  MLPhotoBrowserPhotoImageView.h
//  ewj
//
//  Created by WenYang on 15/10/27.
//  Copyright © 2015年 cre.crv.ewj. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ZLPhotoPickerBrowserPhotoImageViewDelegate;

@interface MLPhotoBrowserPhotoImageView : UIImageView {}

@property (nonatomic, weak) id <ZLPhotoPickerBrowserPhotoImageViewDelegate> tapDelegate;
@property (assign,nonatomic) CGFloat progress;

@end

@protocol ZLPhotoPickerBrowserPhotoImageViewDelegate <NSObject>

@optional

- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch;

@end