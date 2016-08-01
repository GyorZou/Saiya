//
//  QRCodeReaderView.h
//  ewj
//
//  Created by jp007 on 15/11/30.
//  Copyright © 2015年 cre.crv.ewj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QRCodeReader.h"
#import "QRCodeParse.h"
#import "QRScopeView.h"
@interface QRCodeReaderView : UIView

@property (nonatomic,assign) CGRect focusRect;
@property (nonatomic,strong) QRCodeParse * parser;
@property (nonatomic,strong) QRScopeView *scopeView;

@property (nonatomic,copy) void(^handleBlk)(NSString*);

-(void)setupWith:(QRCodeReader*)reader;

-(void)startScan;

-(void)stopScan;

-(void)setLightEnable:(BOOL)able;

@end
