//
//  QRCodeReaderView.m
//  ewj
//
//  Created by jp007 on 15/11/30.
//  Copyright © 2015年 cre.crv.ewj. All rights reserved.
//

#import "QRCodeReaderView.h"
#import <AVFoundation/AVFoundation.h>
#import "QRScopeView.h"
@interface QRCodeReaderView()
{
    QRCodeReader * _reader;
    AVCaptureVideoPreviewLayer * _preview;
}
@end

@implementation QRCodeReaderView

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _preview . frame = self . layer . bounds ;
}
-(void)setupWith:(QRCodeReader *)reader
{
    _reader = reader;
    
}
-(void)prepareLayerIfNeed
{
    if (_preview) {
        [_preview removeFromSuperlayer];
    }
    _preview =[ AVCaptureVideoPreviewLayer layerWithSession : [_reader session] ];
    
    _preview . videoGravity = AVLayerVideoGravityResizeAspectFill ;
    
    _preview . frame = self  . layer . bounds ;
    
    
    /*
     添加区域
     */
    
    
    
    
    
    
    [ self.layer insertSublayer : _preview atIndex : 0 ];
   // [_preview addSublayer:[self scopeLayerWithRect:CGRectMake(0, 0, 100, 100)]];
    CGRect r =CGRectMake(0, 0, 250, 250);
    
    

    
   // _reader.metalOutput.rectOfInterest =r;
    r.origin.x = self.frame.size.width/2-125;
    r.origin.y = 200;
    
    CGRect interst =  CGRectMake(r.origin.y/self.frame.size.height , r.origin.x/self.frame.size.width, r.size.width/self.frame.size.height, r.size.height/self.frame.size.width);
    _reader.metalOutput.rectOfInterest =interst;

    
    QRScopeView *scopeview=[self  scopeView];
    scopeview.scopeRect =r;
    
    [self addSubview:scopeview];
    

}

-(QRScopeView *)scopeView
{
    if (_scopeView==nil) {
        QRScopeView *scopeview=[[QRScopeView alloc] initWithFrame:self.bounds];
        _scopeView =scopeview;
    }
    return _scopeView;
}
-(void)stopScan
{

    [_reader stopRead];
    
}

-(void)startScan
{
    
    /*
     权限判断，是否有权限和设备
     */
    
    /*根据区域设置UI、转换矩阵*/
    if (_reader==nil) {
        _reader = [[QRCodeReader alloc] init];
    }
    
    [self prepareLayerIfNeed];
    
    //_reader.metalOutput.rectOfInterest = CGRectMake(0, 0, 1, 1);
    
    
    
    __weak QRCodeParse * weakParser = _parser;
    __weak QRCodeReader * reader=_reader;
    __weak QRCodeReaderView * ws = self;
    
    _reader.dataHandler =^(NSString * result){
    
        NSLog(@"get result %@",result);
        
        if ([weakParser parseString:result]) {
            
            if (ws.handleBlk) {
                ws.handleBlk(result);
            }
            [reader stopRead];
        }
    
    };
    [_reader startRead];
}

-(void)setLightEnable:(BOOL)able
{
    [_reader setLightEnable:able];
}
@end
