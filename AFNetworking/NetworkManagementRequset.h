//
//  NetworkManagementRequset.h
//  ewj
//
//  Created by admin on 15/3/2.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetworkManagementRequset : AFHTTPSessionManager

+(instancetype)defaultManager;

-(void)requestData:(NSString*)UrlString complation:(void(^)(bool result,id returnData,id cookie))complation;

//-(void)requestCookieData:(NSString*)UrlString cookieString:(NSString*)Cookie postData:(NSDictionary *)PostDic complation:(void(^)(BOOL result,id returnData))complation;

-(NSURLSessionDataTask*)requestGetAddressData:(NSString*)urlString complation:(void(^)(BOOL result,id returnData))complation;

-(NSURLSessionDataTask*)requestGet:(NSString*)urlString  params:(NSDictionary*)dict  complation:(void(^)(BOOL result,id returnData,id cookieData))complation;

-(NSURLSessionDataTask*)requestGet:(NSString*)urlString complation:(void(^)(BOOL result,id returnData,id cookieData))complation;

-(void)requestPhoto:(NSString*)UrlString cookieString:(NSString*)CooKie postPhotoImg:(id)PostData complation:(void(^)(BOOL result,id returnData))complation;

-(NSURLSessionDataTask*)requestPostData:(NSString *)UrlString  postData:(NSDictionary *)PostDic  complation:(BOOL (^)(BOOL result, id returnData))complation;

-(void)requestPostData:(NSString *)UrlString  postData:(NSDictionary *)PostDic  complation:(void (^)(BOOL result, id returnData))complation seeionId:(NSString*)string;

-(void)stops:(NSURLSessionDataTask*)task;


-(void)req:(NSString *)res post:(NSDictionary*)ds complation:(void(^)(BOOL result, id returnData))complation;

//缓存

-(NSURLSessionDataTask*)requestCaca:(NSString *)requestUrl postData:(NSString *)PostDic complation:(void(^)(BOOL result, id returnData))complation;


@end
