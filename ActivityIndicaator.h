//
//  ActivityIndicaator.h
//  ewj
//
//  Created by hutianhu on 15/4/17.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityIndicaator : UIView
@property (weak, nonatomic) IBOutlet UIImageView *loadImg;
@property (weak, nonatomic) IBOutlet UIView * backView;
@property double angle;

-(void) startAnimation;
-(void)endAnimation;
@end
