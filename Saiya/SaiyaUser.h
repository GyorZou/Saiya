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

@property NSString *Address,*FirstName,*OpenId,*Signature,*Vendor,*Weibo;
@property NSArray * Pictures;
@property NSNumber * Id,*AvatarId,*CityId,*DistrictId,*Old,*RewardPoints,*StateProvinceId;
+(instancetype)curUser;
+(NSString*)notificationString;
-(void)reloadData;
-(SaiyaUser*)copiedUser;
@end
