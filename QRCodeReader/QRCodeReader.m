//
//  QRCodeReader.m
//  ewj
//
//  Created by jp007 on 15/11/30.
//  Copyright © 2015年 cre.crv.ewj. All rights reserved.
//

#import "QRCodeReader.h"
#import <AVFoundation/AVFoundation.h>

@interface QRCodeReader ()<AVCaptureMetadataOutputObjectsDelegate>

@property ( strong , nonatomic ) AVCaptureDevice * device;

@property ( strong , nonatomic ) AVCaptureDeviceInput * input;

@property ( strong , nonatomic ) AVCaptureMetadataOutput * output;

@property ( strong , nonatomic ) AVCaptureSession * session;

@end

@implementation QRCodeReader

-(instancetype)init
{
   self = [super init];
    
    [self setUp];
    return self;
}
-(void) setUp
{
    // Device
    
   // static dispatch_once_t token;
 //   dispatch_once(&token, ^{
    if(_device == nil){
        _device = [ AVCaptureDevice defaultDeviceWithMediaType : AVMediaTypeVideo ];
        
        // Input
        //摄像头判断
        NSError *error = nil;
        
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
        
        if (error)
        {
            NSLog(@"没有摄像头-%@", error.localizedDescription);
            
            return;
        }

        _input =input;
        
        // Output
        
        _output = [[ AVCaptureMetadataOutput alloc ] init ];
        
        [ _output setMetadataObjectsDelegate : self queue : dispatch_get_main_queue ()];
        
        
        
        
        // Session
        //拍摄会话
        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        
        // 读取质量，质量越高，可读取小尺寸的二维码
        if ([session canSetSessionPreset:AVCaptureSessionPreset1920x1080])
        {
            [session setSessionPreset:AVCaptureSessionPreset1920x1080];
        }
        else if ([session canSetSessionPreset:AVCaptureSessionPreset1280x720])
        {
            [session setSessionPreset:AVCaptureSessionPreset1280x720];
        }
        else
        {
            [session setSessionPreset:AVCaptureSessionPresetPhoto];
        }
        
        if ([session canAddInput:input])
        {
            [session addInput:input];
        }
        
        if ([session canAddOutput:_output])
        {
            [session addOutput:_output];
        }
        

        
        
        _session =session;
        

        
        
        // 条码类型 AVMetadataObjectTypeQRCode
        _output . metadataObjectTypes = @[ AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode ] ;
    }
    
 //   });
    

}

-(void) startRead
{

    [self setUp];
    
    if(![_session isRunning]){
        [_session startRunning];

    }
}

-(void) pauseRead
{


}
-(void)stopRead
{

    [_session stopRunning];

}
-(AVCaptureSession *)session
{
    return _session;
}
-(AVCaptureMetadataOutput *)metalOutput
{
    return _output;
}


- ( void )captureOutput:( AVCaptureOutput *)captureOutput didOutputMetadataObjects:( NSArray *)metadataObjects fromConnection:( AVCaptureConnection *)connection

{
    
    NSString *stringValue;
    
    if ([metadataObjects count ] > 0 )
        
    {
        
        // 停止扫描
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        
        stringValue = metadataObject. stringValue ;
        if (_dataHandler) {
            _dataHandler(stringValue);
        }
        
    }
    
}
-(void)setLightEnable:(BOOL)able
{
    AVCaptureDevice *device = _device;//[self.reader.readerView device];
    if (![device hasTorch]) {
    } else {
        if (able) {
            // 开启闪光灯
            if(device.torchMode != AVCaptureTorchModeOn ||
               device.flashMode != AVCaptureFlashModeOn){
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                [device unlockForConfiguration];
            }
        } else {
            // 关闭闪光灯
            if(device.torchMode != AVCaptureTorchModeOff ||
               device.flashMode != AVCaptureFlashModeOff){
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                [device unlockForConfiguration];
            }
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //1.获取选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //2.初始化一个监测器
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        //监测到的结果数组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        if (features.count >=1) {
            /**结果对象 */
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:scannedResult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
        else{
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该图片没有包含一个二维码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
        }
        
        
    }];
    
    
}

+(NSString *)codeValueFromImage:(UIImage *)image
{
    
    //2.初始化一个监测器
      CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
        //监测到的结果数组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        if (features.count >=1) {
            /**结果对象 */
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;

            return scannedResult;
            
        }

    return nil;
}
@end
