//
//  SMSSender.h
//  Saiya
//
//  Created by zougyor on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SMSTypeRegister,

}SMSType;
@interface SMSSender : NSObject

+(void)sendSMSToPhone:(NSString*)phone of:(SMSType)type block:(void(^)(BOOL result, id returnData ))blk;
+(void)verifySMS:(NSString*)code atPhone:(NSString*)phone of:(SMSType)type block:(void(^)(BOOL result, id returnData ))blk;

@end
