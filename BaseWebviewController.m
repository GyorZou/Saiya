//
//  EWJWebviewController.m
//  ewj
//
//  Created by jp007 on 15/8/22.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import "BaseWebviewController.h"


@interface BaseWebviewController ()<UIWebViewDelegate>
{
    BOOL _firstLoad;
}

-(UIBarButtonItem*)shareItem;

@end

@implementation BaseWebviewController
@synthesize webView=_webView;
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
        
        [req setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"Cookie"];
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
        [self reload];
    }

    [super viewWillAppear:animated];
    
    
    if (_canShare) {
        self.navigationItem.rightBarButtonItem = [self shareItem];
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }


    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBarHidden=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
 
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
   

    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowBackButton" object:nil];
    
    
}




-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *requestString = [[[request URL]  absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
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
