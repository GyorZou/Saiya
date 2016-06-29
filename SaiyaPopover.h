//
//  SaiyaPopover.h
//  Saiya
//
//  Created by jp007 on 16/6/29.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "DXPopover.h"

@interface SaiyaItem : NSObject
@property NSString * image,*title;
+(id)itemWithTitle:(NSString*)ti image:(NSString*)image;
@end

@interface SaiyaPopover : DXPopover

+(void)showAt:(CGPoint)p withItems:(NSArray*)items inView:(UIView*)v block:(void (^)(int index))blk;

@end
