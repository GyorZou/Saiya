//
//  MLPhotoBrowserDatas.m
//  ewj
//
//  Created by WenYang on 15/10/27.
//  Copyright © 2015年 cre.crv.ewj. All rights reserved.
//


#import "MLPhotoBrowserDatas.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface MLPhotoBrowserDatas ()
@property (nonatomic , strong) ALAssetsLibrary *library;
@end

@implementation MLPhotoBrowserDatas

+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred,^
                  {
                      library = [[ALAssetsLibrary alloc] init];
                  });
    return library;
}

- (ALAssetsLibrary *)library
{
    if (nil == _library)
    {
        _library = [self.class defaultAssetsLibrary];
    }
    
    return _library;
}

#pragma mark - getter
+ (instancetype) defaultPicker{
    return [[self alloc] init];
}

#pragma mark -传入一个AssetsURL来获取UIImage
- (void) getAssetsPhotoWithURL:(NSURL *) url callBack:(callBackBlock ) callBack{
    [self.library assetForURL:url resultBlock:^(ALAsset *asset) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callBack([UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]);
        });
    } failureBlock:nil];
}

@end
