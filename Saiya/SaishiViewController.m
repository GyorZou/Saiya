//
//  SaidouPage.m
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SaishiViewController.h"
#import "GoodsDetailTitle.h"
#import "HotEventsViewController.h"
@interface SaishiViewController ()<ViewPagerDataSource,ViewPagerDelegate>

{
    GoodsDetailTitle  * _titileView;
    
}
@end

@implementation SaishiViewController
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
    self.tabHeight = 45;
    return self;
}
-(UIBarButtonItem *)backItem
{
    return  nil;
}

- (void)viewDidLoad {
    
    self.delegate = self;
    self.dataSource = self;
    
    _tabTitles = @[@"热门",@"关注",@"最新",@"区域",@"分类",@"附近"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    
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


- (NSUInteger)numberOfContentsForViewPager:(ViewPagerController *)viewPager
{
    return 1;
}
- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    
    UIViewController *controler=[HotEventsViewController new];
    controler.view.backgroundColor = [UIColor whiteColor];
    
    controler.container = self;
    NSString *conKey =[NSString stringWithFormat:@"%ld",index];
    [self.controllerDic setValue:controler forKey:conKey];
    
    
    return controler;
}
-(void)viewPager:(ViewPagerController *)viewPager handleTabTapEventAtIndex:(NSUInteger)index
{
    //NSLog(@"");
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
