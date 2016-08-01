//
//  QRScopeView.h
//  SYQRCodeDemo
//
//  Created by jp007 on 15/12/1.
//  Copyright © 2015年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRScopeView : UIView
{
    NSTimer * _lineTimer;
}
@property (nonatomic,assign) CGRect scopeRect;
@end
