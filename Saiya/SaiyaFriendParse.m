//
//  SaiyaFriendParse.m
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SaiyaFriendParse.h"

#import "XWHelper.h"
@implementation SaiyaFriendParse
-(BOOL)parseString:(NSString *)string
{
    if ([XWHelper isNumText:string]) {//数字
        return YES;
    }
    return NO;
}
@end
