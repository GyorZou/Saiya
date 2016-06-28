//
//  UIViewController+ViewContaniner.m
//  Saiya
//
//  Created by jp007 on 16/6/28.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "UIViewController+ViewContaniner.h"
#import <objc/runtime.h>

static const NSString * contanerString  = @"this is pager container";
@implementation UIViewController (ViewContaniner)
- (UIViewController *)container{
    return objc_getAssociatedObject(self, &contanerString);
}

/*
 弱引用
 */
- (void)setContainer:(UIViewController *)vc{
    objc_setAssociatedObject(self, &contanerString, vc, OBJC_ASSOCIATION_ASSIGN);
}







+ (BOOL)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector error:(NSError **)error
{
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    if (!originalMethod) {
        NSString *string = [NSString stringWithFormat:@" %@ 类没有找到 %@ 方法",NSStringFromClass([self class]),NSStringFromSelector(originalSelector)];
        *error = [NSError errorWithDomain:@"NSCocoaErrorDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:string forKey:NSLocalizedDescriptionKey]];
        return NO;
    }
    
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (!swizzledMethod) {
        NSString *string = [NSString stringWithFormat:@" %@ 类没有找到 %@ 方法",NSStringFromClass([self class]),NSStringFromSelector(swizzledSelector)];
        *error = [NSError errorWithDomain:@"NSCocoaErrorDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:string forKey:NSLocalizedDescriptionKey]];
        return NO;
    }
    
    if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
    return YES;
}



+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool
        {
            //  if (!DEBUG) {
            [objc_getClass("UIViewController") swizzleMethod:@selector(navigationController) withMethod:@selector(swizzledNavigationController) error:nil];
          
            
        };
    });
}
-(UINavigationController *)swizzledNavigationController
{
    
    if (self.container != nil) {
        return  [self.container swizzledNavigationController];
    }
    
    return [self swizzledNavigationController];

}
@end
