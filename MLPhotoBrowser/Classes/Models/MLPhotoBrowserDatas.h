//
//  MLPhotoBrowserDatas.h
//  ewj
//
//  Created by WenYang on 15/10/27.
//  Copyright © 2015年 cre.crv.ewj. All rights reserved.
//


#import <UIKit/UIKit.h>

// 回调
typedef void(^callBackBlock)(id obj);

@interface MLPhotoBrowserDatas : NSObject

/**
 *  获取所有组
 */
+ (instancetype) defaultPicker;

/**
 *  传入一个AssetsURL来获取UIImage
 */
- (void) getAssetsPhotoWithURL:(NSURL *)url callBack:(callBackBlock)callBack;

@end
