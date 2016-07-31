//
//  UserAuthenticate.m
//  Saiya
//
//  Created by zougyor on 16/7/30.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "UserAuthenticate.h"
#import "AFNetworking.h"
@interface UserAuthenticate ()

@end

@implementation UserAuthenticate

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)uploadAction:(UIButton*)sender
{

    


}
-(IBAction)saveAction:(id)sender
{

}

- (void)uploadImageWithImage:(UIImage *)image {
    //截取图片
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    // 参数
    
    NSDictionary *parameter       = @{@"token":@"",@"uid"  :@""};
// 访问路径
    NSString *stringURL = [NSString stringWithFormat:@"%@",@""];

    [manager POST:stringURL parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    // 上传文件
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat   = @"yyyyMMddHHmmss";
        NSString *str  = [formatter stringFromDate:[NSDate date]];
        NSString *fileName   = [NSString stringWithFormat:@"%@.jpg", str];
    
        [formData appendPartWithFileData:imageData name:@"photos" fileName:fileName mimeType:@"image/png"];
    
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
