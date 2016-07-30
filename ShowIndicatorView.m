//
//  ShowIndicatorView.m
//  ewj
//
//  Created by hutianhu on 15/4/15.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import "ShowIndicatorView.h"
#import "ActivityIndicaator.h"

ShowIndicatorView *showindicator = nil;

UIActivityIndicatorView *ShowActicityDicatorView = nil;

UIView *Activity;

@implementation ShowIndicatorView
//
//NSArray *viewNIB = [[NSBundle mainBundle] loadNibNamed:@"ActivityIndicaator" owner:self options:nil];
//UIView *shview = viewNIB[0];
//shview.center = [[[[UIApplication sharedApplication] keyWindow] rootViewController] view].center;
//[[[[[UIApplication sharedApplication] keyWindow] rootViewController] view] addSubview:shview];


+(ShowIndicatorView*)ShowIndicator{
    
    static dispatch_once_t showone;
    dispatch_once(&showone, ^{
        showindicator =[[ShowIndicatorView alloc] init];
        NSArray *viewNib = [[NSBundle mainBundle] loadNibNamed:@"ActivityIndicaator" owner:self  options:nil];
        Activity = viewNib[0];
});
    
    return showindicator;
}
-(void)ShowIndicatorInView:(UIView*)view{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.viewHutianhu = view;
        //Activity.center =[[[UIApplication sharedApplication] delegate] window].center;//    view.center;
        Activity.center = CGPointMake([[[UIApplication sharedApplication] delegate] window].center.x, [[[UIApplication sharedApplication] delegate] window].center.y-32.0f);
     //   EWJLog(@"%f,%f",[[[UIApplication sharedApplication] delegate] window].center.x,[[[UIApplication sharedApplication] delegate] window].center.y-32.0f);
        [self.viewHutianhu addSubview:Activity];
        [(ActivityIndicaator*)Activity startAnimation];
    });
    
   
}

-(void)HideIndicatorInView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [(ActivityIndicaator*)Activity endAnimation];
    });
    
    
    
}


@end
