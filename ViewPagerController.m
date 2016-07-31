//
//  ViewPagerController.m
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import "ViewPagerController.h"


#define kDefaultTabHeight 40.0 // Default tab height
#define kDefaultTabOffset 56.0 // Offset of the second and further tabs' from left
#define kDefaultTabWidth 100

#define kDefaultTabLocation 1.0 // 1.0: Top, 0.0: Bottom

#define kDefaultStartFromSecondTab 0.0 // 1.0: YES, 0.0: NO

#define kDefaultCenterCurrentTab 0.0 // 1.0: YES, 0.0: NO

#define kPageViewTag 34

#define kDefaultIndicatorColor [UIColor colorWithRed:178.0/255.0 green:203.0/255.0 blue:57.0/255.0 alpha:0.75]
#define kDefaultTabsViewBackgroundColor [UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:0.75]
#define kDefaultContentViewBackgroundColor [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:0.75]

// TabView for tabs, that provides un/selected state indicators
@class TabView;

@interface TabView : UIView
@property (nonatomic, getter = isSelected) BOOL selected;
@property (nonatomic,strong) UIColor *indicatorColor;
@property (strong,nonatomic) UILabel *indicatorLabel;
@property (nonatomic,strong) UIColor *nTextColor;
@property CGFloat indicatorWidth;

@end

@implementation TabView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)setSelected:(BOOL)selected {
    _selected = selected;
    // Update view as state changed
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    
    [self addSubview:self.indicatorLabel];
    
    UIBezierPath *bezierPath;
    
    if (self.selected) {
        
        bezierPath = [UIBezierPath bezierPath];
        
        CGFloat startPoint = (rect.size.width - self.indicatorWidth)/2;
        CGFloat endPoint = (rect.size.width + self.indicatorWidth)/2;
        
        // Draw the indicator
        [bezierPath moveToPoint:CGPointMake(startPoint,rect.size.height - 1.0)];
        [bezierPath addLineToPoint:CGPointMake(endPoint, rect.size.height - 1.0)];
        [bezierPath setLineWidth:2.0];
        [self.indicatorColor setStroke];
        [bezierPath stroke];
        
        self.indicatorLabel.textColor = self.indicatorColor;
    }
    else
    {
        self.indicatorLabel.textColor = self.nTextColor;
    }
}
@end


// ViewPagerController
@interface ViewPagerController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>

@property UIPageViewController *pageViewController;
@property (assign) id<UIScrollViewDelegate> origPageScrollViewDelegate;

@property UIScrollView *tabsView;
@property UIView *contentView;

@property NSMutableArray *tabs;
@property NSMutableArray *contents;

@property NSUInteger tabCount;
@property NSUInteger contentsCount;
@property (getter = isAnimatingToTab, assign) BOOL animatingToTab;

@property (nonatomic) NSUInteger activeTabIndex;

@end

@implementation ViewPagerController
- (void)dealloc
{
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self defaultSettings];
    }
    return self;
}
-(void)setScrollAble:(BOOL)scrollAble
{
    _scrollAble = scrollAble;
    //_SC
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self defaultSettings];
    }
    return self;
}

- (id)initWithIndex:(NSInteger)index
{
    self =[super initWithNibName:nil bundle:nil];
    if (self) {
        
        [self defaultSettings];
        
        self.index = index;
    }
    
    return self;
}

#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self reloadData];
}

- (void)viewWillLayoutSubviews {
    
    CGRect frame;
    
    frame = _tabsView.frame;
    frame.origin.x = 0.0;
    frame.origin.y = self.tabLocation ? 0.0 : self.view.frame.size.height - self.tabHeight;
    frame.size.width = self.view.bounds.size.width;
    frame.size.height = self.tabHeight;
    _tabsView.frame = frame;
    //这里再加上分割线吧
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0,_tabHeight-0.5, frame.size.width, 0.5)];
        [_tabsView addSubview:_lineView];
    }
    _lineView.backgroundColor = _seperatorColor;
    
    frame = _contentView.frame;
    frame.origin.x = 0.0;
    frame.origin.y = self.tabLocation ? self.tabHeight : 0.0;
    frame.size.width = self.view.bounds.size.width;
    frame.size.height = self.view.frame.size.height - self.tabHeight;
    _contentView.frame = frame;
    
   [self tabScrollToIndex:self.activeTabIndex];
}

- (void)didReceiveMemoryWarning {
    
    
    [super didReceiveMemoryWarning];
}
-(UIViewController *)controllerAtIndex:(NSInteger)index
{
    if (index>_contents.count) {
        return nil;
    }
    
    return [_contents objectAtIndex:index];

}
-(void)setController:(UIViewController *)vc atIndex:(NSInteger)index
{
    if (index>_contents.count) {
        return;
    }
    if (vc==nil||_contents[index]==vc) {
        return;
    }
    
    
    [_contents replaceObjectAtIndex:index withObject:vc];
    
    if (index == _currentControllerIndex) {//如果相同索引，但是控制器又不同一个，是不是得刷一下
        [_pageViewController setViewControllers:@[vc]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
    }
}

-(void)setSelectedIndex:(NSInteger)index animation:(BOOL)ani
{
    
    if (_activeTabIndex == index) {
        if([_delegate respondsToSelector:@selector(viewPager:handleTabTapEventAtIndex:)]){
            
            [_delegate viewPager:self handleTabTapEventAtIndex:index];
        }
        
        return;
    }
     self.animatingToTab = ani;
    // Get the desired viewController
    
    
    if([_delegate respondsToSelector:@selector(viewPager:handleTabTapEventAtIndex:)]){

        [_delegate viewPager:self handleTabTapEventAtIndex:index];
    }else{
        
        UIViewController *viewController = [self viewControllerAtIndex:index];
        // __weak pageViewController to be used in blocks to prevent retaining strong reference to self
        __weak UIPageViewController *weakPageViewController = self.pageViewController;
        __weak ViewPagerController *weakSelf = self;
        
        
        
        if (index < self.activeTabIndex) {
            [self.pageViewController setViewControllers:@[viewController]
                                              direction:UIPageViewControllerNavigationDirectionReverse
                                               animated:YES
                                             completion:^(BOOL completed) {
                                                 weakSelf.animatingToTab = NO;
                                                 // Set the current page again to obtain synchronisation between tabs and content
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     [weakPageViewController setViewControllers:@[viewController]
                                                                                      direction:UIPageViewControllerNavigationDirectionReverse
                                                                                       animated:NO
                                                                                     completion:nil];
                                                 });
                                             }];
        } else if (index > self.activeTabIndex) {
            [self.pageViewController setViewControllers:@[viewController]
                                              direction:UIPageViewControllerNavigationDirectionForward
                                               animated:YES
                                             completion:^(BOOL completed) {
                                                 weakSelf.animatingToTab = NO;
                                                 
                                                 // Set the current page again to obtain synchronisation between tabs and content
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     [weakPageViewController setViewControllers:@[viewController]
                                                                                      direction:UIPageViewControllerNavigationDirectionForward
                                                                                       animated:NO
                                                                                     completion:nil];
                                                 });
                                             }];
        }
        
        _currentControllerIndex = index;
    }
    
    // Set activeTabIndex
    self.activeTabIndex = index;

   // _currentControllerIndex = index;
}
-(NSInteger)currentControllerIndex
{
    return _currentControllerIndex;
}
- (IBAction)handleTapGesture:(id)sender {
    
   
    
    // Get the desired page's index
    UITapGestureRecognizer *tapGestureRecognizer = (UITapGestureRecognizer *)sender;
    UIView *tabView = tapGestureRecognizer.view;
    __block NSUInteger index = [_tabs indexOfObject:tabView];
    
    if ([_delegate respondsToSelector:@selector(viewPager:shouldChangeTabToIndex:)] && [_delegate viewPager:self shouldChangeTabToIndex:index] == NO) {
       // return [self viewControllerAtIndex:index];
        return;
    }

    
    [self setSelectedIndex:index animation:YES];
}

#pragma mark -
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    // Re-align tabs if needed
    self.activeTabIndex = self.activeTabIndex;
}

-(void)tabScrollToIndex:(NSUInteger)index
{
    UIView *tabView = [self tabViewAtIndex:index];
    CGRect frame = tabView.frame;
    
    if (self.centerCurrentTab) {
        
        frame.origin.x += (frame.size.width / 2);
        frame.origin.x -= _tabsView.frame.size.width / 2;
        frame.size.width = _tabsView.frame.size.width;
        
        if (frame.origin.x < 0) {
            frame.origin.x = 0;
        }
        
        if ((frame.origin.x + frame.size.width) > _tabsView.contentSize.width) {
            frame.origin.x = (_tabsView.contentSize.width - _tabsView.frame.size.width);
        }
    } else {
        
        frame.origin.x -= self.tabOffset;
        frame.size.width = self.tabsView.frame.size.width;
    }
    
    [_tabsView scrollRectToVisible:frame animated:YES];


    
    TabView *activeTabView;

    activeTabView = [self tabViewAtIndex:index];
    activeTabView.selected = YES;
}
#pragma mark - Setter/Getter
- (void)setActiveTabIndex:(NSUInteger)activeTabIndex {
    
    if (activeTabIndex == _activeTabIndex) {
        return;
    }
    TabView *activeTabView;
    
    // Set to-be-inactive tab unselected
    activeTabView = [self tabViewAtIndex:self.activeTabIndex];
    activeTabView.selected = NO;
    
    // Set to-be-active tab selected
    activeTabView = [self tabViewAtIndex:activeTabIndex];
    activeTabView.selected = YES;
    
    // Set current activeTabIndex
    _activeTabIndex = activeTabIndex;
    
    // Inform delegate about the change
    if ([self.delegate respondsToSelector:@selector(viewPager:didChangeTabToIndex:)]) {
        [self.delegate viewPager:self didChangeTabToIndex:self.activeTabIndex];
    }
    
    // Bring tab to active position
    // Position the tab in center if centerCurrentTab option provided as YES
    
    [self tabScrollToIndex:activeTabIndex];
}

#pragma mark -
- (void)defaultSettings {
    
    // Default settings
    _controllerDic =[NSMutableDictionary dictionary];
    _currentControllerIndex = 0;
    _tabHeight = kDefaultTabHeight;
    _tabOffset = kDefaultTabOffset;
    _tabWidth = kDefaultTabWidth;
    
    _tabLocation = kDefaultTabLocation;
    
    _startFromSecondTab = kDefaultStartFromSecondTab;
    
    _centerCurrentTab = kDefaultCenterCurrentTab;
    
    _index = 0;
    _isDrawVecLine = NO;
    
    // Default colors
    _indicatorColor = kDefaultIndicatorColor;
    _seperatorColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    _tabsViewBackgroundColor = kDefaultTabsViewBackgroundColor;
    _contentViewBackgroundColor = kDefaultContentViewBackgroundColor;
    _nTextColor = RGBColor(51, 51, 51);
    
    // pageViewController
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:nil];
    
    //Setup some forwarding events to hijack the scrollview
#warning don`t know it`s function
//    self.origPageScrollViewDelegate = ((UIScrollView*)[_pageViewController.view.subviews objectAtIndex:0]).delegate;
//    [((UIScrollView*)[_pageViewController.view.subviews objectAtIndex:0]) setDelegate:self];
    
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    
    _activeTabIndex = 0;
    self.animatingToTab = NO;
}
- (void)reloadData {
    
    // Get settings if provided
    if ([self.delegate respondsToSelector:@selector(viewPager:valueForOption:withDefault:)]) {
        _tabHeight = [self.delegate viewPager:self valueForOption:ViewPagerOptionTabHeight withDefault:kDefaultTabHeight];
        _tabOffset = [self.delegate viewPager:self valueForOption:ViewPagerOptionTabOffset withDefault:kDefaultTabOffset];
        _tabWidth = [self.delegate viewPager:self valueForOption:ViewPagerOptionTabWidth withDefault:kDefaultTabWidth];
        
        _tabLocation = [self.delegate viewPager:self valueForOption:ViewPagerOptionTabLocation withDefault:kDefaultTabLocation];
        
        _startFromSecondTab = [self.delegate viewPager:self valueForOption:ViewPagerOptionStartFromSecondTab withDefault:kDefaultStartFromSecondTab];
        
        _centerCurrentTab = [self.delegate viewPager:self valueForOption:ViewPagerOptionCenterCurrentTab withDefault:kDefaultCenterCurrentTab];
    }
    
    // Get colors if provided
    if ([self.delegate respondsToSelector:@selector(viewPager:colorForComponent:withDefault:)]) {
        _indicatorColor = [self.delegate viewPager:self colorForComponent:ViewPagerIndicator withDefault:kDefaultIndicatorColor];
        _tabsViewBackgroundColor = [self.delegate viewPager:self colorForComponent:ViewPagerTabsView withDefault:kDefaultTabsViewBackgroundColor];
        _contentViewBackgroundColor = [self.delegate viewPager:self colorForComponent:ViewPagerContent withDefault:kDefaultContentViewBackgroundColor];
        _nTextColor = [self.delegate viewPager:self colorForComponent:ViewpagerNtext withDefault:RGBColor(51,51, 51)];
    }
    
    if ([self.delegate respondsToSelector:@selector(viewPager:isDrawVecLineForOption:withDefault:)]) {
        
        _isDrawVecLine = [self.delegate viewPager:self isDrawVecLineForOption:0 withDefault:NO];
    }
    
    // Empty tabs and contents
    [_tabs removeAllObjects];
    [_contents removeAllObjects];
    
    _tabCount = [self.dataSource numberOfTabsForViewPager:self];
    _contentsCount = _tabCount;
    
    if ([self.delegate respondsToSelector:@selector(numberOfContentsForViewPager:)]) {
        
        _contentsCount = [self.dataSource numberOfContentsForViewPager:self];
    }
    
    // Populate arrays with [NSNull null];
    _tabs = [NSMutableArray arrayWithCapacity:_tabCount];
    for (int i = 0; i < _tabCount; i++) {
        [_tabs addObject:[NSNull null]];
    }
    
    _contents = [NSMutableArray arrayWithCapacity:_contentsCount];
    for (int i = 0; i < _contentsCount; i++) {
        [_contents addObject:[NSNull null]];
    }
    
    // Add tabsView
    _tabsView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.tabHeight)];
    _tabsView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _tabsView.backgroundColor = self.tabsViewBackgroundColor;
    _tabsView.showsHorizontalScrollIndicator = NO;
    _tabsView.showsVerticalScrollIndicator = NO;
    
    [self.view insertSubview:_tabsView atIndex:0];
    
    // Add tab views to _tabsView
    CGFloat contentSizeWidth = 0;
    for (int i = 0; i < _tabCount; i++) {
        
        UIView *tabView = [self tabViewAtIndex:i];
        
        CGRect frame = tabView.frame;
        frame.origin.x = contentSizeWidth;
        frame.size.width = self.tabWidth;
        tabView.frame = frame;
        
        [_tabsView addSubview:tabView];
        
        contentSizeWidth += tabView.frame.size.width;
        
        // To capture tap events
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [tabView addGestureRecognizer:tapGestureRecognizer];
        
        if (self.isDrawVecLine) {
            
            if (i < _tabCount) {
                
                CGFloat xPoint = frame.size.width * (i+1);
                UIImageView * lineImageView =[[UIImageView alloc]initWithFrame:CGRectMake(xPoint, 10, 0.5, 20)];
                lineImageView.backgroundColor = RGBColor(180, 180, 180);
                [_tabsView addSubview:lineImageView];
            }
        }
    }
    
    _tabsView.contentSize = CGSizeMake(contentSizeWidth, self.tabHeight);
    
    // Add contentView
    _contentView = [self.view viewWithTag:kPageViewTag];
    
    if (!_contentView) {
        
        _contentView = _pageViewController.view;
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _contentView.backgroundColor = self.contentViewBackgroundColor;
        _contentView.bounds = self.view.bounds;
        _contentView.tag = kPageViewTag;
        
        [self.view insertSubview:_contentView atIndex:0];
    }
    
    // Set first viewController
    UIViewController *viewController;
    
    viewController = [self viewControllerAtIndex:self.index];
    
    if (viewController == nil) {
        viewController = [[UIViewController alloc] init];
        viewController.view = [[UIView alloc] init];
    }
    
    [_pageViewController setViewControllers:@[viewController]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:YES
                                 completion:nil];
    // Set activeTabIndex
    self.activeTabIndex = self.index;
}

- (TabView *)tabViewAtIndex:(NSUInteger)index {
    
    if (index >= _tabCount) {
        return nil;
    }
    
    if ([[_tabs objectAtIndex:index] isEqual:[NSNull null]]) {
        
        UILabel *tabViewContent = (UILabel *)[self.dataSource viewPager:self viewForTabAtIndex:index];
        
        if ([self.delegate respondsToSelector:@selector(viewPager:tabWidthForOption:withDefault:)]) {
            
            self.tabInnerViewWidth = [self.delegate viewPager:self tabWidthForOption:0 withDefault:0];
        }
        else
        {
            self.tabInnerViewWidth = tabViewContent.frame.size.width;
        }
        
        // Create TabView and subview the content
        TabView *tabView = [[TabView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tabWidth, self.tabHeight)];
        tabView.indicatorLabel = tabViewContent;
        [tabView setClipsToBounds:YES];
        [tabView setIndicatorColor:self.indicatorColor];
        [tabView setIndicatorWidth:self.tabInnerViewWidth];
        [tabView setNTextColor:self.nTextColor];
        
        tabViewContent.center = tabView.center;
        
        [_tabs replaceObjectAtIndex:index withObject:tabView];
    }
    
    return [_tabs objectAtIndex:index];
}
- (NSUInteger)indexForTabView:(UIView *)tabView {
    
    return [_tabs indexOfObject:tabView];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    if (index >= _contentsCount ) {
        return nil;
    }
    if ([[_contents objectAtIndex:index] isEqual:[NSNull null]]) {
        
        UIViewController *viewController;
        
        if ([self.dataSource respondsToSelector:@selector(viewPager:contentViewControllerForTabAtIndex:)]) {
            viewController = [self.dataSource viewPager:self contentViewControllerForTabAtIndex:index];
        } else if ([self.dataSource respondsToSelector:@selector(viewPager:contentViewForTabAtIndex:)]) {
            
            UIView *view = [self.dataSource viewPager:self contentViewForTabAtIndex:index];
            
            // Adjust view's bounds to match the pageView's bounds
            UIView *pageView = [self.view viewWithTag:kPageViewTag];
            view.frame = pageView.bounds;
            
            viewController = [UIViewController new];
            viewController.view = view;
        } else {
            viewController = [[UIViewController alloc] init];
            viewController.view = [[UIView alloc] init];
        }
        
        [_contents replaceObjectAtIndex:index withObject:viewController];
    }
    
    return [_contents objectAtIndex:index];
}
- (NSUInteger)indexForViewController:(UIViewController *)viewController {
    
    return [_contents indexOfObject:viewController];
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexForViewController:viewController];
    
    
    index++;
    
    if ([_delegate respondsToSelector:@selector(viewPager:shouldChangeTabToIndex:)]   && [_delegate viewPager:self shouldChangeTabToIndex:index] == NO) {
        
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexForViewController:viewController];
    index--;
    
    if ([_delegate respondsToSelector:@selector(viewPager:shouldChangeTabToIndex:)]   && [_delegate viewPager:self shouldChangeTabToIndex:index] == NO) {
        
        return nil;
    }
    return [self viewControllerAtIndex:index];


}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    NSLog(@"x");

}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    UIViewController *viewController = self.pageViewController.viewControllers[0];
    

    if ([_delegate respondsToSelector:@selector(viewPager:handleControllerTransitionTo:)]) {
        _currentControllerIndex = [_contents indexOfObject:viewController];
        [_delegate viewPager:self handleControllerTransitionTo:viewController];
    }else{
        self.activeTabIndex = [self indexForViewController:viewController];
    }
    
}

#pragma mark - UIScrollViewDelegate, Responding to Scrolling and Dragging
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.origPageScrollViewDelegate scrollViewDidScroll:scrollView];
    }
    
    if (![self isAnimatingToTab]) {
        UIView *tabView = [self tabViewAtIndex:self.activeTabIndex];
        
        // Get the related tab view position
        CGRect frame = tabView.frame;
        
        CGFloat movedRatio = (scrollView.contentOffset.x / scrollView.frame.size.width) - 1;
        frame.origin.x += movedRatio * frame.size.width;
        
        if (self.centerCurrentTab) {
            
            frame.origin.x += (frame.size.width / 2);
            frame.origin.x -= _tabsView.frame.size.width / 2;
            frame.size.width = _tabsView.frame.size.width;
            
            if (frame.origin.x < 0) {
                frame.origin.x = 0;
            }
            
            if ((frame.origin.x + frame.size.width) > _tabsView.contentSize.width) {
                frame.origin.x = (_tabsView.contentSize.width - _tabsView.frame.size.width);
            }
        } else {
            
            frame.origin.x -= self.tabOffset;
            frame.size.width = self.tabsView.frame.size.width;
        }
        
        [_tabsView scrollRectToVisible:frame animated:NO];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.origPageScrollViewDelegate scrollViewWillBeginDragging:scrollView];
    }
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.origPageScrollViewDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.origPageScrollViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.origPageScrollViewDelegate scrollViewShouldScrollToTop:scrollView];
    }
    return NO;
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.origPageScrollViewDelegate scrollViewDidScrollToTop:scrollView];
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.origPageScrollViewDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.origPageScrollViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

#pragma mark - UIScrollViewDelegate, Managing Zooming
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.origPageScrollViewDelegate viewForZoomingInScrollView:scrollView];
    }
    
    return nil;
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.origPageScrollViewDelegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.origPageScrollViewDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.origPageScrollViewDelegate scrollViewDidZoom:scrollView];
    }
}

#pragma mark - UIScrollViewDelegate, Responding to Scrolling Animations
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([self.origPageScrollViewDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.origPageScrollViewDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

#pragma mark-移除控制器的listenter
- (void)removeAllLisenters
{
    if (self.controllerDic) {
        

    }
}


@end
