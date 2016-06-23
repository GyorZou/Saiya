//
//  EWJWebviewController.h
//  ewj
//
//  Created by jp007 on 15/8/22.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWebviewController : BaseViewController
{

    NSString * _callBack;
    
    UIWebView * _webView;
 
}

@property (nonatomic,copy) void (^reloadBlock)(void);
@property (nonatomic,retain) NSString *baseUrl;
@property (nonatomic,strong) NSString * shareUrl;
@property (nonatomic,assign) BOOL canShare;
@property (nonatomic,strong) NSString * imageUrl;//朋友圈的iconurl
@property (nonatomic,strong) UIWebView *webView;




@property (nonatomic,assign) BOOL showMJHeader;

-(void)evaluateJSWithDict:(NSDictionary*)dict;
-(BOOL)handleUrl:(NSString *)url;
-(void)reload;
@end
