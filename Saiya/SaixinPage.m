//
//  SaixinPage.m
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SaixinPage.h"

#import "MessegeConroller.h"
#import "GoodsDetailTitle.h"
@interface SaixinPage ()<ViewPagerDataSource,ViewPagerDelegate>

@end

@implementation SaixinPage
-(instancetype)init
{
    self = [super init];
    self.hidesBottomBarWhenPushed = NO;
    self.tabHeight =45;
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
        // Do any additional setup after loading the view.
    self.navigationController.tabBarItem.image = [[UIImage imageNamed:@"icon-nav2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon-nav2-visited"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self initTitleview];
    
    
    _tabTitles = @[@"消息",@"群组",@"通讯录"];
    
    self.dataSource= self;
    self.delegate=self;
    [super viewDidLoad];

}

-(void)initTitleview
{
    
    GoodsDetailTitle *title =[[GoodsDetailTitle alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    title.selectedTitleColor = [UIColor whiteColor];
    title.unselectedTitleColor = APPCOLOR_GRAY;
    
    
    title.titles=@[@"赛信"];
    
    
    self.navigationItem.titleView=title;
    self.navigationItem.rightBarButtonItem = [self rightItem];
    
    
}
-(void)addItemClick
{

}
-(UIBarButtonItem *)rightItem
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    
    [backBtn addTarget:self action:@selector(addItemClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"icon-addm"] forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];;
    
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
    

    UIViewController *controler=[UIViewController new];
    controler.view.backgroundColor = [UIColor whiteColor];
    if (index == 0) {
        //controler.view.backgroundColor = [UIColor redColor];
        controler = [MessegeConroller new];
    }
    
    
    NSString *conKey =[NSString stringWithFormat:@"%ld",index];
    [self.controllerDic setValue:controler forKey:conKey];
    
    
    return controler;
}


#pragma mark-ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value
{
    
    switch (option) {
        case ViewPagerOptionTabHeight:
            return 40.0f;
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
            return APPCOLOR_ORINGE;
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
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = _tabTitles[index];
    label.font = [UIFont systemFontOfSize:13];
    return label;
}


@end
