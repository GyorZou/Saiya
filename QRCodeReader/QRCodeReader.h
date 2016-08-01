//
//  QRCodeReader.h
//  ewj
//
//  Created by jp007 on 15/11/30.
//  Copyright © 2015年 cre.crv.ewj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface QRCodeReader : NSObject


@property (nonatomic,copy) void (^dataHandler)(NSString *);

/*此版本暂未实现*/
+(NSString*)codeValueFromImage:(UIImage *)image;



-(AVCaptureSession*)session;

-(AVCaptureMetadataOutput*)metalOutput;

-(void) startRead;

-(void) pauseRead;

-(void)stopRead;


-(void)setLightEnable:(BOOL)able;

@end
