//
//  BaseViewController.m
//  ewj
//
//  Created by jp007 on 15/8/11.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController
-(instancetype)init
{
    self = [super init];
    self.hidesBottomBarWhenPushed = YES;

    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.leftBarButtonItem = [self backItem];
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navigationController.navigationBar.translucent=NO;
    //self.navigationController.navigationBar.barTintColor=APPCOLOR_ORINGE;
 
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationItem.leftBarButtonItem = [self backItem];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
        if (self.navigationController.viewControllers.count == 1)//关闭主界面的右滑返回
        {
            return NO;
        }
        else{
            return YES;
        }

    }
    return YES;
}

-(UIImage *)backImage
{
    if (_backImage ==nil) {
        _backImage= [UIImage imageNamed:@"icon-return"];
    }
    return  _backImage;
}
-(UIBarButtonItem *)backItem
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 15);
    
    [backBtn addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
//    UIEdgeInsets edge;
//   // edge.left=-30;
//    [backBtn setImageEdgeInsets:edge];
    
    [backBtn setImage:self.backImage forState:UIControlStateNormal];
   
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}
-(void)goHome{
    
    //[self.navigationController goHome];
    
    
//    [self dismissViewControllerAnimated:YES completion:^{
//      
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"PopToRootViewController" object:nil];
//    }];
    
    
    
    //[self.presentingViewController.navigationController popToRootViewControllerAnimated:YES];
}
-(void)dissmiss
{
    if (self.navigationController &&self.navigationController.viewControllers.count>1) {
         [self.navigationController popViewControllerAnimated:YES];
    }else if (self.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
   
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)showIndicate
{

    [[ShowIndicatorView ShowIndicator] ShowIndicatorInView:self.view];
}

-(void)hideIndicate
{
    [[ShowIndicatorView ShowIndicator] HideIndicatorInView];
}

@end
