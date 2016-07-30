//
//  VendorModel.h
//  Saiya
//
//  Created by jp007 on 16/7/13.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "AsynBaseModel.h"

@interface VendorModel : AsynBaseModel

@property NSNumber * Id,*WatchingNumber,*CustomerId;
@property NSDictionary * Customer;
@property NSString * Description,* PictureUrl,*Name;
@end
