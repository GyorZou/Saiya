//
//  IWantAuthentication.m
//  Saiya
//
//  Created by zougyor on 16/7/30.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "IWantAuthentication.h"
#import "UserAuthenticate.h"
#import "GuanfangAuthenticate.h"

@implementation IWantAuthentication
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
-(IBAction)doAuthen:(UIButton*)sender
{
    long tag = sender.tag;
    if (tag == 0) {//个人
        UserAuthenticate * auther = [UserAuthenticate new];
        [self.navigationController pushViewController:auther animated:YES];
    }else{
        GuanfangAuthenticate * auther = [GuanfangAuthenticate new];
        [self.navigationController pushViewController:auther animated:YES];
    }
}

-(IBAction)doShowDetail:(UIButton*)sender
{
    long tag = sender.tag;
    if (tag == 0) {//官方
        
    }else{
        
    }
}

@end
