//
//  UIImageView+RZWebImage.m
//  FMDBDemo
//
//  Created by Reese Zhang @墨半成霜. on 13-10-31.
//  Copyright (c) 2013年 Reese Zhang @墨半成霜. All rights reserved.
//

#import "UIImageView+RZWebImage.h"
//#import "RZImageDisplay.h"



@implementation UIImageView (RZWebImage)


-(void)setWebImage:(NSURL *)aUrl placeHolder:(UIImage *)placeHolder downloadFlag:(int)flag
{
    [self setUserInteractionEnabled:NO];
   
    [self.layer removeAllAnimations];
   
    self.image = placeHolder;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        //没有下载过这张图片的情况下
        
        //配置下载路径
        NSString *path=[NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/%lu",(unsigned long)aUrl.description.hash];
        NSData *data=[NSData dataWithContentsOfFile:path];
       
        if (!data) {
             [self setImage:placeHolder];
          //  EWJLog(@"准备下载到沙盒路径:%@",path);
            data=[NSData dataWithContentsOfURL:aUrl];
            [data writeToFile:path atomically:YES];
        }
        
        UIImage *image=[UIImage imageWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self setImage:image];
        });

    });

}

-(void)setDownImge:(NSURL *)aUrl block:(void (^)())blockDown{
    
    [self setUserInteractionEnabled:NO];
    [self.layer removeAllAnimations];
    //[self setImage:placeHolder];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        //没有下载过这张图片的情况下
        
        //配置下载路径
        NSString *path=[NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/%lu",(unsigned long)aUrl.description.hash];
        NSData *data=[NSData dataWithContentsOfFile:path];
        if (!data) {
            //EWJLog(@"准备下载到沙盒路径:%@",path);
            data=[NSData dataWithContentsOfURL:aUrl];
            
            [data writeToFile:path atomically:YES];
        }
        UIImage *image=[UIImage imageWithData:data];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self setImage:image];
            blockDown();
        });
        
        
        
        
        
        
    });

    
}
-(void)drawRect:(CGRect)rect{
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

-(void)willEndDisplay
{
    [self setHidden:NO];
}
@end
