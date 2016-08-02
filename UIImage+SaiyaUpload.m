//
//  UIImage+SaiyaUpload.m
//  Saiya
//
//  Created by zougyor on 16/8/2.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "UIImage+SaiyaUpload.h"

@implementation UIImage (SaiyaUpload)
+(void)uploadImage:(UIImage*)imga size:(CGSize)size blk:(void(^)(BOOL suc,NSData*dic))blk
{
    //[UIView animateWithDuration:0 animations:nil];
  
    NSString *string =@"http://saiya.tv/api/AsyncUpload/AsyncPictureUpload";
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    
    [imga drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //imga = [imga imageWithResize:size];
    NSString * ids =[NSString stringWithFormat:@"%@", [SaiyaUser curUser].Id];
    imga = reSizeImage;
    //__weak MineInfoPage *weakSelf = self;
    [[NetworkManagementRequset defaultManager] requestPhoto:string cookieString:ids postPhotoImg:UIImagePNGRepresentation(imga) complation:^(BOOL result, id returnData) {
        if(result){
           
            //weakSelf.photoImg.image = postImage;
            if (blk) {
                blk(YES,returnData);
            }
            
        }else{
            if (blk) {
                blk(NO,returnData);
            }

        }
    }];
}

+ (UIImage*)imageWithImage:(UIImage*)image11 scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image11 drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
