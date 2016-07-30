//
//  ShowIndicatorView.h
//  ewj
//
//  Created by hutianhu on 15/4/15.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShowIndicatorView : NSObject
{
   
}
@property (nonatomic,weak)UIView *viewHutianhu;
+(ShowIndicatorView*)ShowIndicator;

-(void)ShowIndicatorInView:(UIView*)view;

-(void)HideIndicatorInView;
@end
