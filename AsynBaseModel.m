//
//  XWBaseModel.m
//  
//
//  Created by jp007 on 14-11-21.
//  Copyright (c) 2014年 jp007. All rights reserved.
//

#import "AsynBaseModel.h"

@implementation AsynBaseModel


-(id)init
{
    self =[super init];
    if (self) {
        undefProperty=[NSMutableDictionary dictionary];
    }
    return  self;
}

/*should be a dictionary */
-(id)initWithAtrribute:(NSDictionary *)dict
{
    self =[super init];
    if ( self) {
        undefProperty=[NSMutableDictionary dictionary];

        NSDictionary* jsonObj= dict;
        if (jsonObj==nil||![jsonObj isKindOfClass:[NSDictionary class]]) {
            
           // EWJLog(@"failed init from dict ,return default obj");
            return  self;
        }
        
        for (NSString *key in [jsonObj allKeys]) {
            [self setValue:[jsonObj objectForKey:key] forKey:key];
        }
        
    }
    return self;
}
-(id)initWithData:(NSData *)jsonData
{
    self =[super init];
    if (self) {
        undefProperty=[NSMutableDictionary dictionary];
        NSData *data=jsonData;
        NSError *err;
        
        NSDictionary* jsonObj= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        if (err||jsonObj==nil||![jsonObj isKindOfClass:[NSDictionary class]]) {
            
           // EWJLog(@"failed init from string ,return default obj:%@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
            return  self;
        }else if (err){
           // EWJLog(@"server response err:%@ \n response data:%@",err.localizedDescription,[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
        }
        
        for (NSString *key in [jsonObj allKeys]) {
            [self setValue:[jsonObj objectForKey:key] forKey:key];
        }
        
    }
    return self;

}
-(id)initWithJson:(NSString *)jsonString
{
    NSData *data=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self initWithData:data];
      
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    //EWJLog(@"setting undefined {%@:%@} ,save it",key,value);
    if (!undefProperty) {
        undefProperty=[NSMutableDictionary dictionary];
    }
    
    [undefProperty setObject:value forKey:key];
}
-(id)valueForUndefinedKey:(NSString *)key
{
    id des=[undefProperty objectForKey:key];
    if (!des) {//如果不存在  寻求下一目录是否存在 目前为二级目录 改为递归调用可无限下级
        
        for (NSString *key in [undefProperty allKeys]) {
            id obj=[undefProperty objectForKey:key];
            
            
            if ([obj isKindOfClass:[NSDictionary class]]) {//如果是字典 查找
                des=[obj objectForKey:key];
            }
        }

    }
    
    return des;
}
-(NSString *)jsonString
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self properties] options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
       
        return nil;
    }
    return  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSDictionary *)properties
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);

    return props;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"define property:%@,undefine property:%@",[self properties],undefProperty];
}
-(id)objectForKey:(NSString *)key
{
    return  [self valueForKey:key];
}
+(NSString *)jsonString:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return nil;
    }
    return  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

}
@end
