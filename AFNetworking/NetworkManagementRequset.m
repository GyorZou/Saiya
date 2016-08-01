//
//  NetworkManagementRequset.m
//  ewj
//
//  Created by admin on 15/3/2.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import "NetworkManagementRequset.h"
@implementation NetworkManagementRequset

NSURLSessionConfiguration *configuration;


+(instancetype)defaultManager{
    static NetworkManagementRequset *defaultManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        defaultManager = [[NetworkManagementRequset alloc] initWithSessionConfiguration:configuration];
        
        NSURLCache * cache = [[NSURLCache alloc] initWithMemoryCapacity:0*1024*10 diskCapacity:0*1024*10 diskPath:nil];
        [configuration setURLCache:cache];
        //defaultManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        defaultManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    });
    return defaultManager;
}

//获取Cookie值

-(void)requestData:(NSString*)UrlString complation:(void(^)(bool result,id returnData ,id
     
                                                            cookie))complation{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURL *url = [NSURL URLWithString:UrlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    request.cachePolicy=NSURLRequestReloadIgnoringCacheData;
   // request.cachePolicy = 4;
    
    
    //
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/xhtml+xml", @"text/html",@"text/json",@"text/javascript",@"multipart/form-data",@"text/plain",@"application/xml",@"text", nil];
    
    

    
    [[self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            complation(NO,responseObject,nil);
        }else{
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary *CookieDic = [NSDictionary dictionary];
            
            
            
            complation(YES,responseObject,CookieDic);
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }] resume ];
}

-(NSURLSessionDataTask*)requestGetAddressData:(NSString*)urlString complation:(void (^)(BOOL, id))complation{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *string = [NSString stringWithFormat:@"%s",[urlString UTF8String]];
    NSURL *url = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 10;
    //NSURLRequestReloadIgnoringLocalCacheData
    request.cachePolicy=NSURLRequestReloadIgnoringCacheData;
    //request.cachePolicy=4;
    
    
    
    
    
    
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/xhtml+xml", @"text/html",@"text/json",@"text/javascript",@"multipart/form-data",@"text/plain",@"application/xml",@"text", nil];
    
  
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (error) {
            complation(NO,responseObject);
        }else{
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            
            NSDictionary *CookieDic = [NSDictionary dictionary];
            
            if ([response respondsToSelector:@selector(allHeaderFields)])
            {
                NSDictionary *dictionary = [httpResponse allHeaderFields];
                CookieDic = dictionary;
                
                
            }
            complation(YES,responseObject);
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    [task resume];
    return task;

}
-(NSURLSessionDataTask *)requestGet:(NSString *)urlString params:(NSDictionary *)dict complation:(void (^)(BOOL, id, id))complation
{
    //NSMutableString * paramString = [[NSMutableString alloc] init];
    if (dict.count>0) {
        NSMutableArray * temp = [NSMutableArray array];
        for (NSString * key in dict) {
            NSString * value = dict[key];
            
            [temp addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
            
        }
        
        
        NSString * qury =  [temp componentsJoinedByString:@"&"];
        urlString = [NSString stringWithFormat:@"%@?%@",urlString,qury];
 
    }
    return [self requestGet:urlString complation:complation];

}

-(NSURLSessionDataTask*)requestGet:(NSString *)UrlString complation:(void (^)(BOOL, id,id))complation{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *string = [NSString stringWithFormat:@"%s",[UrlString UTF8String]];
    NSURL *url = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 10;
    request.cachePolicy=NSURLRequestReloadIgnoringCacheData;
    
    [self setAccTokenFor:request];
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/xhtml+xml", @"text/html",@"text/json",@"text/javascript",@"multipart/form-data",@"text/plain",@"application/xml",@"text", nil];
 

   NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (error) {
            NSLog(@"%@",error.userInfo);
            complation(NO,responseObject,nil);
        }else{
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            
            NSDictionary *CookieDic = [NSDictionary dictionary];
            
            if ([response respondsToSelector:@selector(allHeaderFields)])
            {
                NSDictionary *dictionary = [httpResponse allHeaderFields];
                CookieDic = dictionary;
                
               
            }
            complation(YES,responseObject,CookieDic);
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    [task resume];
    return task;

}

////应用Cookie,Post数据,请求数据
//
//-(void)requestCookieData:(NSString *)UrlString cookieString:(NSString *)Cookie postData:(NSDictionary *)PostDic  complation:(void (^)(BOOL result, id returnData))complation{
//   [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    
//    
//    NSMutableArray *PostArray = [[NSMutableArray alloc] init];
//    
//    for (NSString *str in [PostDic allKeys]) {
//        [NSString stringWithFormat:@"%@=%@",str,PostDic[str]];
//        [PostArray addObject:[NSString stringWithFormat:@"%@=%@",str,PostDic[str]]];
//    }
//
//    NSData *postdata = [[PostArray componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSURL *url = [NSURL URLWithString:UrlString];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod = @"POST";
//    request.HTTPBody = postdata;
//
//    [request setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"] forHTTPHeaderField:@"Cookie"];
//    
//    [[self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            complation(NO,responseObject);
//        }else{
//           
//            complation(YES,responseObject);
//        }
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    } ] resume];
//    
//}

-(void)requestPostData:(NSString *)UrlString  postData:(NSDictionary *)PostDic  complation:(void (^)(BOOL result, id returnData))complation seeionId:(NSString*)string{
    NSMutableArray *PostArray = [[NSMutableArray alloc] init];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"multipart/form-data", nil];
    
    for (NSString *str in [PostDic allKeys]) {
        [NSString stringWithFormat:@"%@=%@",str,PostDic[str]];
        [PostArray addObject:[NSString stringWithFormat:@"%@=%@",str,PostDic[str]]];
    }
    
    
    NSData *postdata = [[PostArray componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:UrlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = postdata;
    request.cachePolicy = 1;
    request.timeoutInterval = 10;

    

    
    [[self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"%@",responseObject);
            complation(NO,responseObject);
            
        }else{
            
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary *CookieDic = [NSDictionary dictionary];
            if ([response respondsToSelector:@selector(allHeaderFields)])
            {
                NSDictionary *dictionary = [httpResponse allHeaderFields];
                
                CookieDic = dictionary;
                
                
               
            }
            complation(YES,responseObject);
            
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } ] resume];

}

//post
/*
 这里添加一下错误验证
 */
+(NSError *)check:(id)data{

    
    NSError * error;
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSString * string = [data valueForKey:@"status"];
        if([string isKindOfClass:[NSString class]]){
            if ([string isEqualToString:@"noUser"]) {
             NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"login out time"                                                                      forKey:NSLocalizedDescriptionKey];
                error = [NSError errorWithDomain:@"err" code:-1 userInfo:userInfo];
                
            }
        }
    }
    return error;
}
-(NSURLSessionDataTask*)requestPostData:(NSString *)UrlString  postData:(NSDictionary *)PostDic  complation:(BOOL (^)(BOOL result, id returnData))complation {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"multipart/form-data", nil];

    NSMutableArray *PostArray = [[NSMutableArray alloc] init];
    
    for (NSString *str in [PostDic allKeys]) {
        [NSString stringWithFormat:@"%@=%@",str,PostDic[str]];
        [PostArray addObject:[NSString stringWithFormat:@"%@=%@",str,PostDic[str]]];
    }
    NSData *postdata = [[PostArray componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:UrlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = postdata;
    request.timeoutInterval = 30;
    request.cachePolicy = 1;

    [self setAccTokenFor:request];

    
    
     NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
         NSError * checkError = [NetworkManagementRequset check:responseObject];
        if (error||checkError) {
            //EWJLog(@"%@",error);
            NSMutableDictionary * dict = [NSMutableDictionary dictionary];
            
            if(checkError){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"com.ewj.nologin" object:nil];
                dict[@"checkError"] = checkError;
            }
            if (error) {
                dict[@"error"] = error;
            }
            if (responseObject) {
                dict[@"responseObject"] = responseObject;
            }
        
            complation(NO,dict);

        }else{
            
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary *CookieDic = [NSDictionary dictionary];
            
            
            if ([response respondsToSelector:@selector(allHeaderFields)])
            {
                NSDictionary *dictionary = [httpResponse allHeaderFields];
                CookieDic = dictionary;
            }
            
            if ([response isKindOfClass:[NSData class]]) {
                responseObject =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            }
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                complation(YES,responseObject);
            }else
            {
                complation(NO,nil);

            }
            
           
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } ];
    [task resume];
    return task;
}


-(void)requestPhoto:(NSString *)UrlString cookieString:(NSString *)CooKie postPhotoImg:(id)PostData complation:(void (^)(BOOL, id))complation{
    //等待上传图片
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"multipart/form-data", nil];
    [self.requestSerializer setValue:@"image/png" forHTTPHeaderField:@"Content-Type"];
    
    [self POST:UrlString parameters:@{@"customerId":CooKie} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:PostData name:@"qqfile" fileName:@"1.png" mimeType:@"image/png"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        complation(YES,responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        complation(NO,nil);
        
        
    }];
    
}

-(void)stops:(NSURLSessionDataTask *)task{
    if ([task state]==NSURLSessionTaskStateRunning) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [task suspend];
    }
    
}
-(void)setAccTokenFor:(NSMutableURLRequest*)req
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"acc_token"] != nil) {
        NSString * acc = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"acc_token"]];
        if (acc) {
            [req setValue:acc forHTTPHeaderField:@"accToken"];
        }
    }
   
}
-(NSString*)getCookieWithISID:(NSString*)isid Jid:(NSString*)jid
{
    NSString *cookie;
    if (isid) {
        cookie=[NSString stringWithFormat:@"isid=%@;",isid];
        
    }else{
        cookie =   [[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"];
        
    }

    if (cookie ==nil) {
        cookie =@"path=/; HttpOnly";
    }
    if(jid){
        cookie = [NSString stringWithFormat:@"JSESSIONID=%@;%@",jid,cookie];
    }


    return cookie;
}



-(NSURLSessionDataTask*)requestCaca:(NSString *)requestUrl postData:(NSString *)PostDic complation:(void(^)(BOOL result, id returnData))complation{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
  
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"multipart/form-data",@"charset=UTF-8", nil];
    NSURL *url = [NSURL URLWithString:requestUrl];
    
    NSString *imageDir = [NSString stringWithFormat:@"%@/Library/Caches/myCache/", NSHomeDirectory()];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
     [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    

    NSString *cachePath=[NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/myCache/%lu",(unsigned long)PostDic.description.hash];
    
    NSData *data = [NSData dataWithContentsOfFile:cachePath];

    if (data) {
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:cachePath];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        complation(YES,data);
        return nil;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
   request.cachePolicy = 1;
    
    
    

    
    
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            //EWJLog(@"%@",error);
            complation(NO,responseObject);
            
        }else{
            NSMutableData *data = [[NSMutableData alloc] init];
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
            [archiver encodeObject:responseObject forKey:@"Some Key Value"];
            [archiver finishEncoding];
    
            [responseObject writeToFile:cachePath atomically:YES];
        
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            NSDictionary *CookieDic = [NSDictionary dictionary];
            if ([response respondsToSelector:@selector(allHeaderFields)])
            {
                
                
                NSDictionary *dictionary = [httpResponse allHeaderFields];
                CookieDic = dictionary;
              
            }
            complation(YES,responseObject);
            
            
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } ];
    [task resume];
    return task;

}


-(void)req:(NSString *)res post:(NSDictionary*)ds complation:(void(^)(BOOL result, id returnData))complation{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSMutableArray *PostArray = [[NSMutableArray alloc] init];
    
    for (NSString *str in [ds allKeys]) {
        [NSString stringWithFormat:@"%@=%@",str,ds[str]];
        [PostArray addObject:[NSString stringWithFormat:@"%@=%@",str,ds[str]]];
    }
    
    NSData *postdata = [[PostArray componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:res];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
 
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = postdata;
    

    [self.requestSerializer  setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.requestSerializer  setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    // NSString *auth = [[NSUserDefaults standardUserDefaults] objectForKey:@"Authorization"];
    // [manager.requestSerializer setValue:auth forHTTPHeaderField:@"Authorization"];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"multipart/form-data",@"charset=UTF-8", nil];
    
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            //EWJLog(@"%@",error);
            complation(NO,responseObject);
            
        }else{
            
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            
            //NSDictionary *CookieDic = [NSDictionary dictionary];
//            if ([response respondsToSelector:@selector(allHeaderFields)])
//            {
//                NSDictionary *dictionary = [httpResponse allHeaderFields];
//                CookieDic = dictionary;
//                
//                if (CookieDic[@"Set-Cookie"]) {
//                    
//                    if ([CookieDic[@"Set-Cookie"] hasPrefix:@"isid="]) {
//                        [[NSUserDefaults standardUserDefaults] setObject:CookieDic[@"Set-Cookie"] forKey:@"cookie"];
//                    }
//                    
//                }
//            }
            complation(YES,responseObject);
            //[task cancel];
            
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } ];
    [task resume];

}

@end
