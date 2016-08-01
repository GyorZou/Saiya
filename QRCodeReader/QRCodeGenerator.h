//
//  QRCodeGenerator.h
//  SYQRCodeDemo
//
//  Created by jp007 on 15/12/2.
//  Copyright © 2015年 SY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface QRCodeGenerator : NSObject

//生成二维码，正方形

+ (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width;


//生成条形码
+ (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;
@end
