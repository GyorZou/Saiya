//
//  SaidouPage.m
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SaidouPage.h"
#import "GoodsDetailTitle.h"
#import "SaishiViewController.h"
#import "GuanfangController.h"
#import "LoginPage.h"

#import <ShareSDK/ShareSDK.h>

@interface SaidouPage ()<ViewPagerDataSource,ViewPagerDelegate>

{
    GoodsDetailTitle  * _titileView;

}
@end

@implementation SaidouPage
-(instancetype)init
{
    self = [super init];
    self.hidesBottomBarWhenPushed = NO;
    self.tabHeight =0;
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.hidesBottomBarWhenPushed = NO;
    self.navigationItem.leftBarButtonItem = [self backItem];
    self.tabHeight = 0;
    return self;
}
-(UIBarButtonItem *)backItem
{
    return  nil;
}
- (void)viewDidLoad {
    
    self.delegate = self;
    self.dataSource = self;

    _tabTitles = @[@"xx",@"xxx"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.tabBarItem.image = [[UIImage imageNamed:@"icon-nav1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon-nav1-visited"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self initTitleview];
    
    

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"share" style:UIBarButtonItemStyleDone target:self action:@selector(share:)];

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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        [LoginPage showIfNotLogin];
//        if ([self isLogined] == NO) {
//            
//            LoginPage * lg = [LoginPage new];
//            UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:lg];
//            [self.navigationController.tabBarController presentViewController: navi animated:YES completion:nil];
//        }

    });
    
}
-(BOOL)isLogined
{
    return NO;
}
-(void)initTitleview
{
    
    GoodsDetailTitle *title =[[GoodsDetailTitle alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    title.selectedTitleColor = [UIColor whiteColor];
    title.unselectedTitleColor = APPCOLOR_GRAY;
    
    
    title.titles=@[@"赛事",@"官方号"];

    self.navigationItem.titleView=title;
    
    _titileView = title;
    
    //__weak UIScrollView * weakScroll=_pageScrollView;
    __weak typeof(self) weakSelf = self;
   // __weak typeof(_goodsDetailView) weakContent=_goodsDetailView;
    
    _titileView.indexChangeBlock=^(int old ,int index){
        
        [weakSelf setSelectedIndex:index animation:YES];
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager
{
    return [_tabTitles count];
}



- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    
    
    /**
     *购物车字符串
     *EWJ_BDSH（本地生活）,EWJ_KJJP（跨境精品）,EWJ_WJS/门店id（万家送）
     */
    UIViewController * vc = nil;
    if (index == 1) {
         vc =[GuanfangController new];
        //controler.view.backgroundColor = [UIColor whiteColor];

        //vc.view.backgroundColor = [UIColor redColor];
    }else{
        vc = [SaishiViewController new];
        
    }
    vc.container = self;
    
    NSString *conKey =[NSString stringWithFormat:@"%ld",index];
    [self.controllerDic setValue:vc forKey:conKey];
    
    
    return vc;
}

- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index
{
    
        _titileView.index = index;
    
    
}

#pragma mark-ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value
{
    
    switch (option) {
        case ViewPagerOptionTabHeight:
            return 0.0f;
            break;
        case ViewPagerOptionTabOffset:
            return 0.0f;
            break;
        case ViewPagerOptionTabWidth:
            return SCREENWIDTH/[_tabTitles count];
            break;
        case ViewPagerOptionTabLocation:
            return 1.0f;
            break;
        case ViewPagerOptionStartFromSecondTab:
            return 0.0f;
            break;
        case ViewPagerOptionCenterCurrentTab:
            return 0.0f;
            break;
        default:
            break;
    }
    return value;
}

- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color
{
    switch (component) {
        case ViewPagerIndicator:
            return RGBColor(0, 0, 0);
            break;
        case ViewPagerTabsView:
            return RGBColor(255, 255, 255);
            break;
        case ViewPagerContent:
            return RGBColor(234, 234, 234);
            break;
        case ViewpagerNtext:
            return RGBColor(66,66, 66);
            break;
        default:
            break;
    }
    
    return color;
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index
{
    
    return nil;
}
@end
