//
//  QRScopeView.m
//  SYQRCodeDemo
//
//  Created by jp007 on 15/12/1.
//  Copyright © 2015年 SY. All rights reserved.
//

#import "QRScopeView.h"

@interface QRScopeView ()
{
    long _lineY;
}
@end
@implementation QRScopeView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor=[UIColor clearColor];
    return self;
}
-(UIImage *)lineImage
{

    return  nil;
}
//-(void)setScopeRect:(CGRect)scopeRect
//{
//    _scopeRect=scopeRect;
//    _lineY = scopeRect.origin.y;
//}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    NSLog(@"super =%@",newSuperview);
    [_lineTimer invalidate];
    _lineTimer=nil;
    if (newSuperview==nil) {
        
    }else{
        UIImageView * imageView=[[UIImageView alloc] init];
        imageView.image =[self lineImage];
        imageView.backgroundColor =[UIColor redColor];
       
        imageView.layer.shadowColor = [UIColor whiteColor].CGColor;
        imageView.layer.shadowOffset = CGSizeMake(0, 2);
        _lineTimer =[NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(runLine:) userInfo:imageView repeats:YES];
    }
}

-(void)runLine:(NSTimer*)timer
{
    UIImageView *imageView = [timer userInfo];
  
    
    CGRect value = _scopeRect;
    value.size.height = 2;
    value.origin.y =_lineY +_scopeRect.origin.y;
    
    _lineY+=2;

    _lineY =_lineY%((int) _scopeRect.size.height);
    imageView.frame=value;
    [self addSubview:imageView];
   
    
    
    
    
}
-(void)drawRect:(CGRect)rect
{
    CGContextRef context =   UIGraphicsGetCurrentContext();
    


    CGContextAddRect(context, rect);
    [[[UIColor blackColor] colorWithAlphaComponent:.7] set];

    CGContextFillPath(context);
    
    
    CGContextClearRect(context, _scopeRect);
    

    
    
}
@end
