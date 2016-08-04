//
//  SaiyaUser.h
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "AsynBaseModel.h"

@interface SaiyaUser : AsynBaseModel
{

}
@property NSString * Email,*Username,*Nickname,*Gender,*AvatarUrl,*Description;

@property NSString *Address,*FirstName,*OpenId,*Signature,*Weibo,*EmotionalState;
@property NSArray * Pictures;
@property NSDictionary * Entertainer,*Vendor;
@property NSNumber * Id,*AvatarId,*CityId,*DistrictId,*Old,*RewardPoints,*StateProvinceId;
+(instancetype)curUser;
+(NSString*)notificationString;
-(void)reloadData;
-(void)reloadDataWithCompletion:(void(^)(BOOL))blk;
-(SaiyaUser*)copiedUser;
-(BOOL)isLogined;
@end
