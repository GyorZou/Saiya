//
//  InfoDetailViewController.h
//  Saiya
//
//  Created by jp007 on 16/7/14.
//  Copyright © 2016年 crv. All rights reserved.
//

typedef enum {
    InfoTypeUndefine,
    InfoTypeSaishi,
    InfoTypeVendor,
    InfoTypeUser,
    
}InfoType;


#import "NoneBarWebviewController.h"

@interface InfoDetailViewController : NoneBarWebviewController
@property (nonatomic,assign) InfoType type;
@property (nonatomic,strong) NSString *  infoId; 
@end
