//
//  XWBaseModel.h
//  
//
//  Created by jp007 on 14-11-21.
//  Copyright (c) 2014年 jp007. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface AsynBaseModel : NSObject
{
    NSMutableDictionary *undefProperty;
    
}

-(NSString*)jsonString;
-(id)initWithJson:(NSString*)jsonString;
-(id)initWithData:(NSData *)jsonData;
-(id)initWithAtrribute:(NSDictionary*)dict;
-(id)objectForKey:(NSString*)key;
-(BOOL)containKey:(NSString*)key;
+(NSString*)jsonString:(NSDictionary*)dict;
@end
