//
//  SMSSender.m
//  Saiya
//
//  Created by zougyor on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SMSSender.h"

@implementation SMSSender
+(void)sendSMSToPhone:(NSString *)phone of:(SMSType)type block:(void (^)(BOOL, id))blk
{
    NSString * t = @"1";
    switch (type) {
        case SMSTypeRegister:
            
            break;
            
        default:
            break;
    }
    
    NSDictionary * dict = @{@"phone":phone,@"smsType":t};
    NSString * url = @"http://saiya.tv/api/Common/SendSMS";
    [[NetworkManagementRequset manager] requestPostData:url postData:dict complation:^BOOL(BOOL result, id returnData) {
        
        if (blk) {
            blk(result,returnData);
        }
        return YES;
    }];
    
}
+(void)verifySMS:(NSString *)code atPhone:(NSString *)phone of:(SMSType)type block:(void (^)(BOOL, id))blk
{
    NSString * t = @"1";
    switch (type) {
        case SMSTypeRegister:
            
            break;
            
        default:
            break;
    }
    NSDictionary * dict = @{@"phone":phone,@"smsType":t,@"code":code};
    NSString * url = @"http://saiya.tv/api/Common/CheckSMS";
    [[NetworkManagementRequset manager] requestPostData:url postData:dict complation:^BOOL(BOOL result, id returnData) {
        
        if (blk) {
            blk(result,returnData);
        }
        return YES;
    }];
}
@end
