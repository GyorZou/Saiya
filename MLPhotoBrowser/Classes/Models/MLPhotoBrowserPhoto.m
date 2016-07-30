//
//  MLPhotoBrowserPhoto.m
//  ewj
//
//  Created by WenYang on 15/10/27.
//  Copyright © 2015年 cre.crv.ewj. All rights reserved.
//


#import "MLPhotoBrowserPhoto.h"

@implementation MLPhotoBrowserPhoto

- (void)setPhotoObj:(id)photoObj{
    _photoObj = photoObj;
    
    if ([photoObj isKindOfClass:[MLPhotoBrowserAssets class]]) {
        MLPhotoBrowserAssets *asset = (MLPhotoBrowserAssets *)photoObj;
        self.asset = asset;
    }else if ([photoObj isKindOfClass:[NSURL class]]){
        self.photoURL = photoObj;
    }else if ([photoObj isKindOfClass:[UIImage class]]){
        self.photoImage = photoObj;
    }else if ([photoObj isKindOfClass:[NSString class]]){
        self.photoURL = [NSURL URLWithString:photoObj];
    }else{
        NSAssert(true == true, @"您传入的类型有问题");
    }
}

- (UIImage *)photoImage{
    if (!_photoImage && self.asset) {
        _photoImage = [self.asset originImage];
    }
    return _photoImage;
}

- (UIImage *)thumbImage{
    if (!_thumbImage) {
        if (self.asset) {
            _thumbImage = [self.asset thumbImage];
        }else if (_photoImage){
            _thumbImage = _photoImage;
        }
    }
    return _thumbImage;
}

#pragma mark - 传入一个MLPhotoBrowserAssets对象，返回一个UIImage
+ (UIImage *)getImageWithAssets:(MLPhotoBrowserAssets *)asset{
    if ([asset isKindOfClass:[MLPhotoBrowserAssets class]]) {
        return asset.thumbImage;
    }else if([asset isKindOfClass:[UIImage class]]){
        return (UIImage *)asset;
    }
    return nil;
}

#pragma mark - 传入一个图片对象，可以是URL/UIImage/NSString，返回一个实例
+ (instancetype)photoAnyImageObjWith:(id)imageObj{
    MLPhotoBrowserPhoto *photo = [[self alloc] init];
    [photo setPhotoObj:imageObj];
    return photo;
}

@end
