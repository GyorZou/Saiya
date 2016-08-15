//
//  InfoDetailViewController.m
//  Saiya
//
//  Created by jp007 on 16/7/14.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "InfoDetailViewController.h"
#import "SaiquanDetailViewController.h"
#import "CreateSaishiViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface InfoDetailViewController ()

@end

@implementation InfoDetailViewController

-(NSString*)url
{
    NSString * root = @"http://saiya.tv/h5/";
    NSString * child = @"vendor.html";
    switch (_type) {
        case InfoTypeSaishi:
            child = @"competionsummary.html";
            break;
        case InfoTypeUser:
            child = @"entertainer.html";
            break;
        case InfoTypeUndefine:
            return self.baseUrl;
            break;
        default:
            
            break;
    }
    return [root stringByAppendingString:child];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        self.baseUrl = [self url];

    
}
-(void)initJSContext
{
    [super initJSContext];

    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSString * s = [def objectForKey:@"acc_token"];
    if (s) {
        NSString *js = [NSString stringWithFormat:@"setParams('%@','%@')",_infoId,s];
        [self.jsContext evaluateScript:js];
    }
    
    __weak typeof(self) wS = self;
    self.jsContext[@"viewSaiquan"] = ^(NSString * sid){
        
        SaiquanDetailViewController * detail = [SaiquanDetailViewController new];
        detail.saiquanId = sid;
        detail.baseUrl = @"http://saiya.tv/h5/saiquan_details.html";
        [wS.navigationController pushViewController:detail animated:YES];
    };
    
    
    self.jsContext[@"openShare"] = ^(NSString * sid){
        
        [wS share:nil];
        
    };
    self.jsContext[@"publishComptetion"] = ^{
        
        //[wS share:nil];
        //[NWFToastView showToast:@"请发布赛事"];
        CreateSaishiViewController * none = [CreateSaishiViewController new];
        none.baseUrl = @"http://saiya.tv/h5/add_competetion.html";
        [wS.navigationController pushViewController:none animated:YES];
        
        
    };
    
    
    self.jsContext[@"viewCompetion"] = ^(NSString * sid){
        
        InfoDetailViewController * detail = [InfoDetailViewController new];
        detail.infoId = sid;
        detail.type = InfoTypeSaishi;
        [wS.navigationController pushViewController:detail animated:YES];
    };
    
    
    
    void (^action)(NSString*,InfoType) = ^(NSString* sid,InfoType type){
        
        InfoDetailViewController * detail = [InfoDetailViewController new];
        detail.infoId = sid;
        detail.type = type;
        [wS.navigationController pushViewController:detail animated:YES];
    };
    self.jsContext[@"viewEntertainer"] = ^(NSString * sid){
        action(sid,InfoTypeUser);
    };
    self.jsContext[@"viewVendor"] = ^(NSString * sid){
        action(sid,InfoTypeVendor);
    };
    self.jsContext[@"viewCompetion"] = ^(NSString * sid){
        action(sid,InfoTypeSaishi);
    };

    //publishComptetion


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(BOOL)handleUrl:(NSString *)url
{
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
