//
//  SanFriendsController.m
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SanFriendsController.h"
#import "AddFriendViewController.h"
#import "SaiyaFriendParse.h"

@implementation SanFriendsController
-(void)dissmiss
{
    
    
    [super dissmiss];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [view stopScan];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [view startScan];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
     view = [[QRCodeReaderView alloc] initWithFrame:self.view.bounds];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    //[view startScan];
    
    view.parser = [[SaiyaFriendParse alloc] init];
    __weak SanFriendsController * ws =self;
    view.handleBlk = ^(NSString * uid){
        AddFriendViewController *addController = [[AddFriendViewController alloc] initWithStyle:UITableViewStylePlain];
        addController.hidesBottomBarWhenPushed = YES;
        addController.defaultString = uid;
        [ws.navigationController pushViewController:addController animated:YES];
    };

}

@end
