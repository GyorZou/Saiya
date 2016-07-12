//
//  HotEventModel.h
//  Saiya
//
//  Created by jp007 on 16/7/12.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "AsynBaseModel.h"

@interface HotEventModel : AsynBaseModel
@property NSNumber * Id,*VendorId,*CategoryId;
@property NSDictionary * Vendor;
@property NSArray* Images;
@property NSString * StartDate,* EndDate,*CreatedOn,*Name,*LevelStr,*Level;
@end
