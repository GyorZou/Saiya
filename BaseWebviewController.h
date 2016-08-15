//
//  EWJWebviewController.h
//  ewj
//
//  Created by jp007 on 15/8/22.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import "BaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <ShareSDK/ShareSDK.h>

@interface BaseWebviewController : BaseViewController<UIWebViewDelegate>
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
@property (nonatomic, strong, readonly) JSContext    *jsContext; 

@property (nonatomic,assign) BOOL hideNaviBar;


@property (nonatomic,assign) BOOL showMJHeader;

@property (nonatomic,strong) id<ISSContent> publishContent;
-(void)initJSContext;
-(void)evaluateJSWithDict:(NSDictionary*)dict;

/**
 *  是否可以跳转此url
 *
 *  @param url url
 *
 *  @return 是否可以
 */
-(BOOL)handleUrl:(NSString *)url;
-(void)reload;
@end
