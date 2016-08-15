//
//  EScrollerView.m
//  icoiniPad
//
//  Created by Ethan on 12-11-24.
//
//

#import "EScrollerView.h"
#import "UIImageView+RZWebImage.h"
#import "UIImageView+AFNetworking.h"

#import "MLPhotoBrowserAssets.h"
#import "MLPhotoBrowserViewController.h"


#define UISCREENWIDTH  self.bounds.size.width//广告的宽度
#define UISCREENHEIGHT  self.bounds.size.height//广告的高度

//static CGFloat const chageImageTime = 1.0;

@interface EScrollerView()<MLPhotoBrowserViewControllerDataSource,MLPhotoBrowserViewControllerDelegate>
{
    BOOL _isTimeUp;
    
    NSTimer *_moveTime;
    
    BOOL isTime;
    
     NSMutableArray * _imageUrl;
}

@end

@implementation EScrollerView
@synthesize delegate;

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _autoScroll = YES;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self  =[super initWithFrame:frame];
    if (self) {
        _autoScroll = YES;
    }
    return self;
}
-(instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

-(NSArray *)imgArr
{//最后一个第一
    NSMutableArray * mu =  [NSMutableArray arrayWithArray:imageArray];
    [mu removeObjectAtIndex:0];
    [mu removeLastObject];

    return mu;
}
-(UIImage *)firstImage
{
    return  [imageArray firstObject];
}
-(void)ImageArray:(NSArray *)imgArr holders:(NSArray *)holder TitleArray:(NSArray *)titArr rect:(CGRect)rect isBanner:(BOOL)isBanner
{
    //return;
    [scrollView removeFromSuperview];
    scrollView = nil;
    self.userInteractionEnabled=YES;
    if ([imgArr count]==0) {
        return;
    }
    NSMutableArray *tempArray=[NSMutableArray arrayWithArray:imgArr];
    NSMutableArray *ht=[NSMutableArray arrayWithArray:holder];
    if (_autoScroll) {
        
        [tempArray insertObject:[imgArr objectAtIndex:([imgArr count]-1)] atIndex:0];
        [tempArray addObject:[imgArr objectAtIndex:0]];
        if (ht.count>0) {
            [ht insertObject:[holder objectAtIndex:([holder count]-1)] atIndex:0];
            [ht addObject:[holder objectAtIndex:0]];
 
        }
    }
    holder = ht;
    imageArray=[NSArray arrayWithArray:tempArray] ;
    _imageUrl = [NSMutableArray arrayWithArray:imageArray];
    viewSize = self.frame;
    if (rect.size.width !=0) {
        viewSize=rect;
    }
    
    NSUInteger pageCount=[imageArray count];
    [scrollView removeFromSuperview];
    scrollView = nil;
    if (!scrollView) {
        scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, viewSize.size.height)];
    }
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * pageCount, viewSize.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    
    scrollView.delegate = self;
    for (int i=0; i<pageCount; i++) {
        NSString *imgURL= nil;
        if (isBanner) {
            imgURL =  [imageArray objectAtIndex:i][@"imgUrl"];
        }
        else {
            imgURL = [imageArray objectAtIndex:i];
        }
        UIImageView *imgView=[[UIImageView alloc] init] ;
        
        // imgView.contentMode = UIViewContentModeScaleAspectFit;
        if ([imgURL hasPrefix:@"http://"]) {
            //[imgView setImageWithUrl:imgURL defaultImage:[UIImage imageNamed:@"BannerImg"]];
            UIImage * holderImg;
            if (holder.count > 0) {
                
                holderImg = holder[i];
            }
            [imgView setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:holderImg];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
        }
        
        [imgView setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*i, 0,[UIScreen mainScreen].bounds.size.width, viewSize.size.height)];
        imgView.tag=i+50;
        
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.layer.masksToBounds = YES;
        UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
        [Tap setNumberOfTapsRequired:1];
        [Tap setNumberOfTouchesRequired:1];
        imgView.userInteractionEnabled=YES;
        [imgView addGestureRecognizer:Tap];
        [scrollView addSubview:imgView];
    }
    if (_autoScroll) {
        [scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
    }
    
    [self addSubview:scrollView];
    
    float pageControlWidth=(pageCount-2)*10.0f+40.f;
    float pagecontrolHeight=20.0f;
    pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((self.frame.size.width-pageControlWidth)/2,viewSize.size.height-20, pageControlWidth, pagecontrolHeight)];
    pageControl.currentPage=0;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    pageControl.numberOfPages=(pageCount-2);
    if (_autoScroll == NO) {
        pageControl.numberOfPages=pageCount;
    }
    [self addSubview:pageControl];
    
    _pageControl=pageControl;
    
    
    
    if (_autoScroll) {
        [_moveTime invalidate];
        
        _moveTime = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(animalMoveImage) userInfo:nil repeats:YES];
        //[[NSRunLoop mainRunLoop] addTimer:_moveTime forMode:NSRunLoopCommonModes];
        
    }
    _isTimeUp = NO;
    
    isTime = YES;
    
    currentPageIndex = 1;


}
-(void)ImageArray:(NSArray *)imgArr TitleArray:(NSArray *)titArr rect:(CGRect)rect isBanner:(BOOL)isBanner{
    
    [self ImageArray:imgArr holders:nil TitleArray:titArr rect:rect isBanner:isBanner];
}
-(int)curIndex
{
    return  currentPageIndex;
}
-(void)refreshLoad{
    [_moveTime invalidate];
    if (scrollView) {
        [scrollView removeFromSuperview];
    }
//    while (scrollView) {
//        [scrollView removeFromSuperview];
//    }
    
}
           
#pragma mark - 计时器到时,系统滚动图片
- (void)animalMoveImage
{
    
    if (!self.superview) {
        [_moveTime invalidate];
        return;
    }
    [scrollView setContentOffset:CGPointMake(viewSize.size.width*(currentPageIndex++), 0) animated:YES];
    
    if (currentPageIndex == [imageArray count]) {
        isTime = NO;
        pageControl.currentPage = 0;
    }
    else {
        isTime = YES;
    }
    
    if (currentPageIndex > [imageArray count] - 1) {
        currentPageIndex = 2;
        double delayInSeconds = .2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [scrollView setContentOffset:CGPointMake(viewSize.size.width, 0) animated:NO];
            isTime = YES;
        });
    }
    
    
    
    
    if (currentPageIndex<[imageArray count]-2) {
        _isTimeUp = YES;
    }
    
}



-(void)deleteView{
    [_moveTime invalidate];
   
}

-(void)dealloc{
    [_moveTime invalidate];
    //EWJLog(@"imagescroll dealloced");
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;

    currentPageIndex=page;
    if (isTime) {
        pageControl.currentPage=(page-1);
        
        if (_autoScroll == NO) {
            pageControl.currentPage=page;
        }
    }
   
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    
    if (_autoScroll) {
    
        if (currentPageIndex==0) {
            [_scrollView setContentOffset:CGPointMake(([imageArray count]-2)*viewSize.size.width, 0)];
        }
  
        if (currentPageIndex==([imageArray count]-1)) {
            [_scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
        }
    }

}


- (void)imagePressed:(UITapGestureRecognizer *)sender
{
    if (_clickBlock && sender.view.tag  > 2) {
        int i = 0;
        if(_autoScroll){
            i = 2;
        }
        _clickBlock((sender.view.tag - 50)%(imageArray.count - i) );
        return;
    }
    if ([delegate respondsToSelector:@selector(EScrollerViewDidClicked:)]) {
        if (sender.view.tag<=2) {
            
        }else{
            [delegate EScrollerViewDidClicked:sender.view.tag - 50];
        }
    }
    
    if (self.showPickerVC) {
                
        NSMutableArray * imageUrl = [NSMutableArray array];
        
        for (NSString * urlString in _imageUrl) {
        
            NSMutableString * urlMutableString = [NSMutableString stringWithString:urlString];
            NSRange  urlStringRange = [urlMutableString rangeOfString:@"_640X640"];
            if (urlStringRange.location != NSNotFound) {
                //  [urlMutableString replaceCharactersInRange:urlStringRange withString:@"_800X800"];//2016.1.23 jp007注释，因暂时只要640*640即可

            }
            [imageUrl addObject:urlMutableString];
        }
        _imageUrl = imageUrl;
        [self tapBrowser:sender];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect = self.frame;
    rect.size.width = [UIScreen mainScreen].bounds.size.width;
    scrollView.frame = rect;
    self.frame = rect;
}

#pragma mark - 图片
- (void)tapBrowser:(UITapGestureRecognizer  *)gesture{
    
    NSInteger toalImageCount = _imageUrl.count;
    
    NSInteger row = gesture.view.tag - 50;
    
    //  3 1 2 3 1
    if (_autoScroll) {
        if (row == 0)
            row = toalImageCount-2;
        else if (row == toalImageCount -1)
            row = 1;
        else
            row = row -1;
        // 4
        if (row >= _imageUrl.count -2) {
            row = 0;
        }
    }
  
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    MLPhotoBrowserViewController *photoBrowser = [[MLPhotoBrowserViewController alloc] init];
    photoBrowser.status = UIViewAnimationAnimationStatusZoom;
    photoBrowser.delegate = self;
    photoBrowser.dataSource = self;
    photoBrowser.isHeaderImage = YES;
    photoBrowser.currentIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:0];
    [photoBrowser showPickerVc:self.showPickerVC];
}

#pragma mark - <MLPhotoBrowserViewControllerDataSource>
- (NSInteger)photoBrowser:(MLPhotoBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{
    if (_autoScroll) {
        return _imageUrl.count-2;
    }
    return _imageUrl.count;
}

#pragma mark - 每个组展示什么图片,需要包装下MLPhotoBrowserPhoto
- (MLPhotoBrowserPhoto *) photoBrowser:(MLPhotoBrowserViewController *)browser photoAtIndexPath:(NSIndexPath *)indexPath{
    
    MLPhotoBrowserPhoto *photo = [[MLPhotoBrowserPhoto alloc] init];
    
    NSString * imgUrl = _imageUrl[indexPath.row + (_autoScroll? 1:0)];
    
    photo.photoObj = imgUrl;
    
    NSInteger row = indexPath.row+ (_autoScroll? 1:0);
    
    UIImageView * imageView = (UIImageView *)[scrollView viewWithTag:50 + row];
    if (imageView && [imageView isKindOfClass:[UIImageView class]]) {

//        UIImageView * imageViewS = [[UIImageView alloc] init];
//        imageViewS.image = imageView.image;
//        imageViewS.center = self.center;
//        imageViewS.bounds = CGRectMake(0, 0, 100, 100);
        photo.toView = imageView;
//        photo.thumbImage = nil;
        photo.thumbImage = imageView.image;
    }
    return photo;
}

@end
