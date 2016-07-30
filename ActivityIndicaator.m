//
//  ActivityIndicaator.m
//  ewj
//
//  Created by hutianhu on 15/4/17.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import "ActivityIndicaator.h"

@implementation ActivityIndicaator
static NSString *loadinglogo = @"loadinglogo";

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */
- (void)drawRect:(CGRect)rect{
    
 }
-(void) startAnimation
{
    self.hidden = NO;
    NSArray *magesArray = [NSArray arrayWithObjects:
                           [UIImage imageNamed:@"loading"],
                           [UIImage imageNamed:@"loading1"],
                           [UIImage imageNamed:@"loading2"],
                           [UIImage imageNamed:@"loading3"],
                           [UIImage imageNamed:@"loading4"],
                           [UIImage imageNamed:@"loading5"],
                           [UIImage imageNamed:@"loading6"],
                           [UIImage imageNamed:@"loading7"],nil];
    
    self.loadImg.animationImages = magesArray;
    self.loadImg.animationDuration = 0.5f;
    self.loadImg.animationRepeatCount = 0;
    [self.loadImg startAnimating];

}


-(void)layoutSubviews{
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0f;
    [super layoutSubviews];
    self.frame = CGRectMake([[[UIApplication sharedApplication] delegate] window].frame.origin.x, [[[UIApplication sharedApplication] delegate] window].frame.origin.y, 80, 80);
    self.center = CGPointMake([[[UIApplication sharedApplication] delegate] window].center.x, [[[UIApplication sharedApplication] delegate] window].frame.size.height/2-64);
   // self.center = [[[UIApplication sharedApplication] delegate] window].center;
    self.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:239/255.0f alpha:.9f];
    
    [super layoutSubviews];
    

}


-(void)endAnimation
{
    self.hidden = YES;
    [self.loadImg stopAnimating];
}


@end
