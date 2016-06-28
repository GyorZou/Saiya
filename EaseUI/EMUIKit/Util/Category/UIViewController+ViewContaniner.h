//
//  UIViewController+ViewContaniner.h
//  Saiya
//
//  Created by jp007 on 16/6/28.
//  Copyright © 2016年 crv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ViewContaniner)
- (UIViewController *)container;

/*
 弱引用
 */
- (void)setContainer:(UIViewController *)vc;
@end
