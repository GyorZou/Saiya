
//
//  QRCodeGenerator.m
//  SYQRCodeDemo
//
//  Created by jp007 on 15/12/2.
//  Copyright © 2015年 SY. All rights reserved.
//

#import "QRCodeGenerator.h"
#import <CoreImage/CoreImage.h>

@implementation QRCodeGenerator

+ (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width {
    
    // 生成二维码图片
    CIImage *qrcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    qrcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / qrcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = width / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef cgimg = [context createCGImage:transformedImage fromRect:[transformedImage extent]];
    
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    
    CGImageRelease(cgimg);
    
    return newImg;
}

+ (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    // 生成二维码图片
    CIImage *barcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    barcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / barcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / barcodeImage.extent.size.height;
    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    //UIImage * image =[UIImage imageWithCIImage:transformedImage];//用这个生成的image会根据imageview的size拉伸，即时设置contentMode也没用
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef cgimg = [context createCGImage:transformedImage fromRect:[transformedImage extent]];
    
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    
    CGImageRelease(cgimg);
    
    return newImg;//[UIImage imageWithCIImage:transformedImage];
}

@end
