//
//  CustomerContent.m
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "CustomerContent.h"

@implementation CustomerContent
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    [self addTarget:self action:@selector(doSm) forControlEvents:UIControlEventTouchUpInside];
    return self;
}
-(void)doSm
{
    [self removeFromSuperview];
}
+(void)showView:(UIView *)view
{
    CustomerContent * v = [[CustomerContent alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    
    view.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2);
    [v addSubview:view];
    v.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    [[UIApplication sharedApplication].keyWindow addSubview:v];

}
@end
