//
//  ViewPagerController.h
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UIViewController+ViewContaniner.h"


typedef NS_ENUM(NSUInteger, ViewPagerOption) {
    ViewPagerOptionTabHeight,
    ViewPagerOptionTabOffset,
    ViewPagerOptionTabWidth,
    ViewPagerOptionTabLocation,
    ViewPagerOptionStartFromSecondTab,
    ViewPagerOptionCenterCurrentTab
};

typedef NS_ENUM(NSUInteger, ViewPagerComponent) {
    ViewPagerIndicator,
    ViewPagerTabsView,
    ViewPagerContent,
    ViewpagerNtext
};

@protocol ViewPagerDataSource;
@protocol ViewPagerDelegate;

@interface ViewPagerController : BaseViewController
{
    NSInteger _currentControllerIndex;
    UIView * _lineView;
}

@property(nonatomic,weak) id<ViewPagerDataSource> dataSource;
@property(nonatomic,weak) id<ViewPagerDelegate> delegate;

@property(nonatomic,strong) NSMutableDictionary *controllerDic;//控制器存储
@property(nonatomic,assign,readonly) NSInteger currentControllerIndex;//当前控制器的index
@property (nonatomic,assign) BOOL scrollAble;

#pragma mark ViewPagerOptions
// Tab bar's height, defaults to 49.0
@property CGFloat tabHeight;
// Tab bar's offset from left, defaults to 56.0
@property CGFloat tabOffset;
// Any tab item's width, defaults to 128.0. To-do: make this dynamic
@property CGFloat tabWidth;

// 1.0: Top, 0.0: Bottom, changes tab bar's location in the screen
// Defaults to Top
@property CGFloat tabLocation;

// 1.0: YES, 0.0: NO, defines if view should appear with the second or the first tab
// Defaults to NO
@property CGFloat startFromSecondTab;

// 1.0: YES, 0.0: NO, defines if tabs should be centered, with the given tabWidth
// Defaults to NO
@property CGFloat centerCurrentTab;
//0:第一个 1:第二个... 索引 外部传入 可以直接显示到指定的控制器
@property NSInteger index;
//YES:需要画分隔垂直线 NO:不需要
@property BOOL      isDrawVecLine;
//tab下横线的宽度
@property CGFloat   tabInnerViewWidth;

#pragma mark Colors
// Colors for several parts
//未选中的文本颜色
@property UIColor *nTextColor;
//指示条的颜色
@property UIColor *indicatorColor,*seperatorColor;
//tab的背景颜色
@property UIColor *tabsViewBackgroundColor;
//内容页面的背景颜色
@property UIColor *contentViewBackgroundColor;

//传入index作为控制器的索引
- (id)initWithIndex:(NSInteger)index;

#pragma mark Methods
// Reload all tabs and contents
- (void)reloadData;

- (void)removeAllLisenters;

-(void)setSelectedIndex:(NSInteger)index animation:(BOOL)ani ;
-(void)setController:(UIViewController*)vc atIndex:(NSInteger)index;

-(UIViewController*)controllerAtIndex:(NSInteger)index;
@end

#pragma mark dataSource
@protocol ViewPagerDataSource <NSObject>

// Asks dataSource how many tabs will be
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager;
// Asks dataSource to give a view to display as a tab item
// It is suggested to return a view with a clearColor background
// So that un/selected states can be clearly seen
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index;

@optional
// The content for any tab. Return a view controller and ViewPager will use its view to show as content
- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index;
- (UIView *)viewPager:(ViewPagerController *)viewPager contentViewForTabAtIndex:(NSUInteger)index;

- (NSUInteger)numberOfContentsForViewPager:(ViewPagerController *)viewPager;


@end

#pragma mark delegate
@protocol ViewPagerDelegate <NSObject>

@optional

- (BOOL)viewPager:(ViewPagerController *)viewPager shouldChangeTabToIndex:(NSUInteger)index;
- (void)viewPager:(ViewPagerController *)viewPager handleTabTapEventAtIndex:(NSUInteger)index;
- (void)viewPager:(ViewPagerController *)viewPager handleControllerTransitionTo:(UIViewController*)vc;

// delegate object must implement this method if wants to be informed when a tab changes
- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index;
// Every time - reloadData called, ViewPager will ask its delegate for option values
// So you don't have to set options from ViewPager itself
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value;
/*
 * Use this method to customize the look and feel.
 * viewPager will ask its delegate for colors for its components.
 * And if they are provided, it will use them, otherwise it will use default colors.
 * Also not that, colors for tab and content views will change the tabView's and contentView's background
 * (you should provide these views with a clearColor to see the colors),
 * and indicator will change its own color.
 */
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color;

//是否需要画垂直分割线
- (BOOL)viewPager:(ViewPagerController *)viewPager isDrawVecLineForOption:(ViewPagerOption)option withDefault:(BOOL)value;

//导航栏单独选项的横线宽度
- (CGFloat)viewPager:(ViewPagerController *)viewPager tabWidthForOption:(ViewPagerOption)option withDefault:(CGFloat)value;

@end
