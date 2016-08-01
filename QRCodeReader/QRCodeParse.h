//
//  QRCodeParse.h
//  ewj
//
//  Created by jp007 on 15/11/30.
//  Copyright © 2015年 cre.crv.ewj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QRCodeParse : NSObject
@property (nonatomic,strong) NSArray * regulars;

-(BOOL)parseString:(NSString*)string;

@end
