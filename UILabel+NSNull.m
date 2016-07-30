//
//  UILabel+NSNull.m
//  ewj
//
//  Created by jp007 on 15/9/2.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import "UILabel+NSNull.h"
#import <objc/runtime.h>
@implementation UILabel (NSNull)
+(void)load
{
    
    Method setText =class_getInstanceMethod(self, @selector(setText:));
    Method setNullText=class_getInstanceMethod(self, @selector(setNullText:));
    method_exchangeImplementations(setText, setNullText);
}
-(void)setNullText:(NSString *)text
{
    if([text isKindOfClass:[NSString class]]){
        if ( [text isEqualToString:@"null"]||[text isEqualToString:@"NUll"]||[text isEqualToString:@"Null"]||[text isEqualToString:@"Nil"]||[text isEqualToString:@"nil"]) {
            text=@"";
        }
        [self setNullText:text];
    }

}
@end

@implementation NSString (NSNull)

-(NSString *)description
{
    if ([self isEqualToString:@"null"]||[self isEqualToString:@"NUll"]||[self isEqualToString:@"Null"]||[self isEqualToString:@"Nil"]||[self isEqualToString:@"nil"]) {
        return @"";
    }

    return self;
}

@end

