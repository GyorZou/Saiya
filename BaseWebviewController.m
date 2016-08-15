//
//  EWJWebviewController.m
//  ewj
//
//  Created by jp007 on 15/8/22.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import "BaseWebviewController.h"

#import "MJRefresh.h"
#import <ShareSDK/ShareSDK.h>
@interface BaseWebviewController ()
{
    BOOL _firstLoad;
    BOOL _lastState;
    UIButton * _refreshBtn;
}

-(UIBarButtonItem*)shareItem;

@end

@implementation BaseWebviewController
@synthesize webView=_webView;
-(UIBarButtonItem *)shareItem
{
    return nil;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.hidesBottomBarWhenPushed = YES;
    return self;
}
-(void)dealloc
{
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   // self.imageUrl = @"http://image2.ewj.com/2015/6/29/4060558.png";

    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIWebView *web =[[UIWebView alloc] initWithFrame:self.view.bounds];
    web.autoresizingMask =UIViewAutoresizingFlexibleHeight;
    
    
    [self.view addSubview:web];

    web.delegate=self;
    
    _webView = web;
    
    
    _firstLoad = YES;

    _refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _refreshBtn.center = self.view.center;
    [self.view addSubview:_refreshBtn];
    _refreshBtn.titleLabel.textColor = [UIColor lightGrayColor];
    [_refreshBtn setTitle:@"点击重新加载" forState:0];
    _refreshBtn.frame = self.view.bounds;
    _refreshBtn.hidden = YES;
    [_refreshBtn addTarget:self action:@selector(redo) forControlEvents:UIControlEventTouchUpInside];
}
-(void)redo
{
    _refreshBtn.hidden = YES;
    [_webView reload];
}
-(NSString *)shareUrl
{
    if (_shareUrl) {
        return _shareUrl;
    }
    return _baseUrl;
}
-(BOOL)isRemoteUrl
{
    return [_baseUrl hasPrefix:@"http"]||[_baseUrl hasPrefix:@"www"];
}
-(void)refresh
{
    if (_reloadBlock) {
        _reloadBlock();
    }
    [self reload];
}

-(void)reload
{
    if ([self isRemoteUrl]) {
        NSMutableURLRequest *req =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:_baseUrl]];
        req.cachePolicy=NSURLRequestReloadIgnoringCacheData;
        
      //  [req setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"Cookie"];
        //[req setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X; en-us) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53" forHTTPHeaderField:@"User-Agent"];
        
        
        UIWebView *web =[[UIWebView alloc] initWithFrame:self.view.bounds];
        web.autoresizingMask =UIViewAutoresizingFlexibleHeight;
  
        
        [self.view addSubview:web];
        
        web.delegate=self;

        [_webView removeFromSuperview];
        
        _webView =web;
        [_webView loadRequest:req];
    }else{
        NSString*    urlStr = [NSString stringWithFormat:@"file://%@", _baseUrl];

        NSMutableURLRequest *req =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        req.cachePolicy=NSURLRequestReloadIgnoringLocalCacheData;
      
       [_webView loadRequest:req];
        

    }

    
    
    _firstLoad = NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    // self.navigationController.navigationBarHidden=YES;

    
    if (_firstLoad) {
        _lastState = self.navigationController.navigationBarHidden;
        [self reload];
    }
    self.navigationController.navigationBarHidden = _hideNaviBar;

    [super viewWillAppear:animated];
    
    
    if (_canShare) {
        self.navigationItem.rightBarButtonItem = [self shareItem];
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }

        
}


-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = _lastState;
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBarHidden=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[ShowIndicatorView ShowIndicator] HideIndicatorInView];

    _refreshBtn.hidden = NO;
    [_webView.scrollView.mj_header endRefreshing];

    [NWFToastView dismissProgress];

 
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[ShowIndicatorView ShowIndicator] ShowIndicatorInView:self.view];
  //  [NWFToastView showProgress:@"加载中..."];
    [self superInitJSContext];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[NWFToastView dismissProgress];
    [[ShowIndicatorView ShowIndicator] HideIndicatorInView];
    
    [_webView.scrollView.mj_header endRefreshing];

    [self superInitJSContext];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowBackButton" object:nil];
    
    
}


-(void)addMJHeader{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    _webView.scrollView.mj_header = header;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //[self superInitJSContext];
    
    if (_webView.scrollView.mj_header == nil && self.showMJHeader == YES) {
        [self addMJHeader];
    }

    NSString *requestString = [[[request URL]  absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"web loading:%@",requestString);
    
    if ([requestString hasPrefix:@"ewj:"]) {
       
    }else if ([requestString hasPrefix:@"http"] && ![requestString isEqualToString:_baseUrl]){
        
        return [self handleUrl:requestString];
    }else if ([requestString hasPrefix:@"about:blank"]){
        return NO;
    }
    
    return YES;
}
-(void)evaluateJSWithDict:(NSDictionary*)dict
{

  

}
-(void)superInitJSContext
{
        __weak typeof(self) weakSelf = self;
        _jsContext = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
 
        
        _jsContext[@"backPress"] = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _jsContext[@"showToast"] = ^(NSString*s){
            //[weakSelf.navigationController popViewControllerAnimated:YES];
            NSLog(@"show toast:%@",s);
            [NWFToastView  showToast:s];
        };

        _jsContext[@"getAccToken"] = (NSString*)^ (){
            NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
            NSString * s = [def objectForKey:@"acc_token"];
            return s;
        };
        NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
        NSString * s = [def objectForKey:@"acc_token"];
    
    
        if (s) {
            NSString *js = [NSString stringWithFormat:@"setAcctoken('%@')",s];
            [_jsContext evaluateScript:js];
        }
    
        //goLogin
        _jsContext[@"goLogin"] = ^ {
            //[weakSelf.navigationController popViewControllerAnimated:YES];
            [LoginPage showWithCompletion:^{
                [weakSelf refresh];
            }];
        };

    
    __weak typeof(self) ws = self;
        _jsContext[@"openShare"] = ^(NSString * sid){
        
        [ws share:nil];
        
    };
        [self initJSContext];
}

-(IBAction)share:(id)sender{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"card"  ofType:@"png"];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容测试"
                                       defaultContent:@"默认分享内容测试，没内容时显示"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"pmmq"
                                                  url:@"http://www.sharesdk.cn"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                    [NWFToastView showToast:@"分享成功"];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败");
                                    [NWFToastView showToast:@"分享失败"];
                                }
                            }];
}

-(void)initJSContext
{

}
-(BOOL)handleUrl:(NSString *)url
{

//    if (![url isEqualToString:_baseUrl]) {
//        EWJWebviewController *vc=    [[EWJWebviewController alloc] init];
//        vc.baseUrl=url;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//
    return YES;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && [_callBack isKindOfClass:[NSString class]]) {
        [_webView stringByEvaluatingJavaScriptFromString:_callBack];
        _callBack = nil;
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





-(void)dissmiss
{
    if (self.navigationController &&self.navigationController.viewControllers.count>1) {
        
       
            if ([_webView canGoBack]) {
                [_webView goBack];
            }else{
                 [self.navigationController popViewControllerAnimated:YES];
            }
        
        
    }else if (self.presentingViewController){
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    
}

@end
