//
//  SaiyaUser.m
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SaiyaUser.h"

id curUser;
@implementation SaiyaUser

+(instancetype)curUser
{
    if(curUser == nil){
        curUser = [[[self class] alloc] initWithAtrribute:nil];
    }
    return curUser;
}
-(id)initWithAtrribute:(NSDictionary *)dict
{
    if (curUser) {
        [curUser updateAttribute:dict];
    }else{
        self =  [super initWithAtrribute:dict];
        curUser = self;
    }
    return self;
}
+(NSString *)notificationString
{
    return @"saiyauser_update";
}
-(void)reloadData
{
    NSString* root = @"http://saiya.tv/api/customer/GetInfo";
    
    [[NetworkManagementRequset manager] requestGet:root complation:^(BOOL result, id returnData, id cookieData) {
        if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
            NSDictionary * datas = returnData[@"data"];
            [self updateAttribute:datas];

            [[NSNotificationCenter defaultCenter] postNotificationName:[[self class] notificationString]  object:nil];
        }
        
        
    }];

}
@end
