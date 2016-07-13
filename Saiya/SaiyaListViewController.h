//
//  SaiyaListViewController.h
//  Saiya
//
//  Created by jp007 on 16/7/13.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "EaseRefreshTableViewController.h"
#import "MJRefresh.h"

@protocol  SaiyaListViewControllerProtocol;

@interface SaiyaListViewController : EaseRefreshTableViewController<SaiyaListViewControllerProtocol>

@end



@protocol SaiyaListViewControllerProtocol <NSObject>
-(void)parseData:(NSDictionary*)data;
-(NSString*)dataUrl;
-(NSDictionary*)requestParams;
-(void)loadData:(BOOL)refresh;
@end
