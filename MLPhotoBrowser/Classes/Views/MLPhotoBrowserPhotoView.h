//
//  MLPhotoBrowserPhotoView.h
//  ewj
//
//  Created by WenYang on 15/10/27.
//  Copyright © 2015年 cre.crv.ewj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ZLPhotoPickerBrowserPhotoViewDelegate;

@interface MLPhotoBrowserPhotoView : UIView {}

@property (nonatomic, weak) id <ZLPhotoPickerBrowserPhotoViewDelegate> tapDelegate;

@end

@protocol ZLPhotoPickerBrowserPhotoViewDelegate <NSObject>

@optional

- (void)view:(UIView *)view singleTapDetected:(UITouch *)touch;
- (void)view:(UIView *)view doubleTapDetected:(UITouch *)touch;

@end