//
//  SaiquanPage.m
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SaiquanPage.h"

#import "GoodsDetailTitle.h"
#import "SearchViewController.h"
#import "SaiyaPopover.h"
#import "BaseWebviewController.h"
#import "SaiquanDetailViewController.h"
@interface SaiquanPage ()
{
    BaseWebviewController *_web;
    BOOL f;
}
@end

@implementation SaiquanPage
-(instancetype)init
{
    self = [super init];
    self.hidesBottomBarWhenPushed = NO;
    
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.hidesBottomBarWhenPushed = NO;
    self.navigationItem.leftBarButtonItem = [self backItem];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.tabBarItem.image = [[UIImage imageNamed:@"icon-nav3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon-nav3-visited"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   // self.title = @"赛圈";
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationItem.rightBarButtonItem = [self rightItem];
    [self initTitleview];
    //_web = [BaseWebviewController new];
    //_web.view.backgroundColor = [UIColor whiteColor];
    self.baseUrl = @"http://saiya.tv/h5/saiquan.html";
    self.showMJHeader = YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (f== NO) {
        //_web.baseUrl = @"http://saiya.tv/h5/saiquan.html";
      //  [self.view addSubview:_web.view];
    }
    f = YES;
    
}
-(void)initTitleview
{
    
    GoodsDetailTitle *title =[[GoodsDetailTitle alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    title.selectedTitleColor = [UIColor whiteColor];
    title.unselectedTitleColor = APPCOLOR_GRAY;
    
    
    title.titles=@[@"赛圈"];
    
    self.navigationItem.titleView=title;
    

}

-(UIBarButtonItem *)rightItem
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    
    [backBtn addTarget:self action:@selector(releaseItemClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"icon-release"] forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];;

}
-(UIBarButtonItem *)backItem
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    
    [backBtn addTarget:self action:@selector(searchItemClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"icon-search"] forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];;
}
-(void)releaseItemClick
{
    if ([LoginPage showIfNotLogin] == YES) {
        SaiyaItem * item0 = [SaiyaItem itemWithTitle:@"文字" image:@"icon-writing"];
        SaiyaItem * item1 = [SaiyaItem itemWithTitle:@"照片" image:@"icon-photo"];
        SaiyaItem * item2 = [SaiyaItem itemWithTitle:@"视频" image:@"icon-video"];
        SaiyaItem * item3 = [SaiyaItem itemWithTitle:@"直播" image:@"icon-live"];
        SaiyaItem * item4 = [SaiyaItem itemWithTitle:@"赛事(官方号项)" image:@"icon-event"];
        
        
        [SaiyaPopover showAt:CGPointMake(SCREENWIDTH , 64) withItems:@[item0,item1,item2,item3,item4] inView:self.view.window block:^(int index) {
            NSLog(@"xxxx,%d",index);
            
            switch (index) {
                case 0:
                    
                    break;
                    
                default:
                    break;
            }
        
        }];
    }
    

}
-(void)searchItemClick
{
    SearchViewController * s = [SearchViewController new];
    
    [self.navigationController pushViewController:s animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initJSContext
{
    __weak typeof(self) wS = self;
    self.jsContext[@"viewSaiquan"] = ^(NSString * sid){
    
        SaiquanDetailViewController * detail = [SaiquanDetailViewController new];
        detail.saiquanId = sid;
        detail.baseUrl = @"http://saiya.tv/h5/saiquan_details.html";
        [wS.navigationController pushViewController:detail animated:YES];
    };
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL)handleUrl:(NSString *)url
{
    NoneBarWebviewController * web = [NoneBarWebviewController new];
    web.baseUrl = url;
    [self.navigationController pushViewController:web animated:YES];
    return NO;
}
@end
