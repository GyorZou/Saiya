//
//  MLPhotoBrowserPhotoScrollView.h
//  ewj
//
//  Created by WenYang on 15/10/27.
//  Copyright © 2015年 cre.crv.ewj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MLPhotoBrowserPhotoImageView.h"
#import "MLPhotoBrowserPhotoView.h"
#import "MLPhotoBrowserPhoto.h"

typedef void(^callBackBlock)(id obj);
@class MLPhotoBrowserPhotoScrollView;

@protocol ZLPhotoPickerPhotoScrollViewDelegate <NSObject>
@optional
// 单击调用
- (void) pickerPhotoScrollViewDidSingleClick:(MLPhotoBrowserPhotoScrollView *)photoScrollView;
@end

@interface MLPhotoBrowserPhotoScrollView : UIScrollView <UIScrollViewDelegate, ZLPhotoPickerBrowserPhotoImageViewDelegate,ZLPhotoPickerBrowserPhotoViewDelegate>

@property (nonatomic,strong) MLPhotoBrowserPhoto *photo;
@property (nonatomic, weak) id <ZLPhotoPickerPhotoScrollViewDelegate> photoScrollViewDelegate;
// 长按图片的操作，可以外面传入
@property (strong,nonatomic) UIActionSheet *sheet;
// 单击销毁的block
@property (copy,nonatomic) callBackBlock callback;

@end
