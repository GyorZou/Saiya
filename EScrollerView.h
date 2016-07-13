//
//  EScrollerView.h
//  icoiniPad
//
//  Created by Ethan on 12-11-24.
//
//

#import <UIKit/UIKit.h>

@protocol EScrollerViewDelegate <NSObject>
@optional
-(void)EScrollerViewDidClicked:(NSUInteger)index;
@end

@interface EScrollerView : UIView<UIScrollViewDelegate> {
	CGRect viewSize;
	UIScrollView *scrollView;
    NSArray *imageArray;
    UIPageControl *pageControl;
    id<EScrollerViewDelegate> delegate;
    int currentPageIndex;
}
@property(nonatomic,strong) id<EScrollerViewDelegate> delegate;
@property(nonatomic,assign,readonly) int curIndex;
@property(nonatomic,assign,readonly) UIPageControl * pageControl;
@property (nonatomic,assign) UIViewContentMode imageViewContentMode;
@property (nonatomic,copy) void (^clickBlock)(NSUInteger);

/*
 不自动滚动，停滞无限循环，2016.3月需求，有点逗比，唯有呵呵
 */
@property (nonatomic,assign) BOOL autoScroll;
@property (nonatomic,weak) UIViewController * showPickerVC;

-(NSString *)firstImage;
-(void)ImageArray:(NSArray *)imgArr TitleArray:(NSArray *)titArr rect:(CGRect)rect isBanner:(BOOL)isBanner;

-(void)deleteView;

-(void)refreshLoad;


@end
