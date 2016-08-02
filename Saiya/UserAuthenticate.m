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
{
    UIActionSheet * _curSheet;
    AsynBaseModel * m1,*m2,*m3;
}
@end

@implementation UserAuthenticate

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)uploadAction:(UIButton*)sender
{

    int tag = sender.tag;
    

    [self photoImgButtonPressed:tag];


}
-(IBAction)saveAction:(id)sender
{
    if (_infoLabel.text.length==0) {
        [NWFToastView showToast:@"请填写姓名"];
        return;
    }else if ( m1==nil ){
        [NWFToastView showToast:@"请上传正面照"];
        return;
    }else if ( m2==nil ){
        [NWFToastView showToast:@"请上传侧面照"];
        return;
    }else if ( m3==nil ){
        [NWFToastView showToast:@"请上传持证上半身照"];
        return;
    }
    
    
    NSString* root = @"http://saiya.tv/API/Entertainer/SaveEntertainer";

    /*
     Name:qwe轻微123
     PictureId:1376
     Picture2Id:1377
     Picture3Id:1378
     */
    NSNumber * id1 = [[m1 valueForKey:@"data"] valueForKey:@"pictureId"];
    NSNumber * id2 = [[m2 valueForKey:@"data"] valueForKey:@"pictureId"];
    NSNumber * id3 = [[m3 valueForKey:@"data"] valueForKey:@"pictureId"];
    NSDictionary * d = @{@"Name":_infoLabel.text,@"PictureId":id1,@"Picture2Id":id2,@"Picture3Id":id3};
    [self showIndicate];
    [[NetworkManagementRequset manager]  requestPostData:root postData:d complation:^BOOL(BOOL result, id returnData) {
        [self hideIndicate];
        if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
            [NWFToastView showToast:@"保存成功"];
        }else{
            [NWFToastView showToast:@"保存失败"];
            
        }
        
        
        return YES;
    }];

}
-(void)loadData
{
    SaiyaUser * user = [SaiyaUser curUser];
    if (user.Entertainer) {
        NSString* root = @"http://saiya.tv/API/Entertainer/GetEntertainerById";
        NSDictionary * d = @{@"entertainerId":user.Entertainer[@"Id"]};
        
        [self showIndicate];
        [[NetworkManagementRequset manager]  requestPostData:root postData:d complation:^BOOL(BOOL result, id returnData) {
            [self hideIndicate];
            if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
                NSDictionary * data = returnData[@"data"];
                _infoLabel.text =data[@"Name"];
                
                
                NSString * url = data[@"Picture1Url"];
                NSNumber * num = data[@"PictureId"];
                if (url &&num) {
                    NSDictionary * d1 =@{@"data":@{@"pictureId":num,@"pictureUrl":url}};
                    m1 = [[AsynBaseModel alloc] initWithAtrribute:d1];
                    [_c1 setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"c1"]];
                }
                
                
                url = data[@"Picture2Url"];
                num = data[@"Picture2Id"];
                if (url &&num) {
                    NSDictionary * d1 =@{@"data":@{@"pictureId":num,@"pictureUrl":url}};
                    m2 = [[AsynBaseModel alloc] initWithAtrribute:d1];
                    
                    [_c2 setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"c2"]];
                }
                
               url = data[@"Picture3Url"];
                 num = data[@"Picture3Id"];
                if (url &&num) {
                    NSDictionary * d1 =@{@"data":@{@"pictureId":num,@"pictureUrl":url}};
                    m3 = [[AsynBaseModel alloc] initWithAtrribute:d1];
                    
                    [_c3 setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"c3"]];
                }
                
                
                
            }else{
                
                
            }
            
            
            return YES;
        }];
    }

}

- (void)uploadImageWithImage:(UIImage *)image {
    //截取图片

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - ActionSheet
-(void)photoImgButtonPressed:(int)tag{
    
    if([LoginPage showIfNotLogin] == NO){
        return;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"相册", @"拍照",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.tag = tag;
    [actionSheet showInView:self.view];
    _curSheet = actionSheet;
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        //相册
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        imagePicker.delegate = self;
        
        [self  presentViewController:imagePicker animated:YES completion:^{
            
        }];
        
    }else if (buttonIndex==1){
        //拍照
        
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
        
        if (!isCamera) {
            
            
            return ;
            
        }
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        imagePicker.delegate = self;
        
        // 编辑模式
        
        imagePicker.allowsEditing = YES;
        [self  presentViewController:imagePicker animated:YES completion:^{
            
        }];
        
        
    }else{
        
    }
}

/**
 保存图片到手机操作之后就会调用
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) { // 保存失败
        //(@"保存图片到手机失败");
    } else { // 保存成功
        //[MBProgressHUD showSuccess:@"保存成功"];
        //  ZpLog(@"保存图片到手机成功");
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    UIImage *imga;
    
    imga = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {// 保存到手机相册
        UIImageWriteToSavedPhotosAlbum(imga, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    __block UIImage* postImage = imga;
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    CGSize   size = imga.size;
   
        if (size.width > 1000) {
            size.width = size.width/2;
            size.height = size.height/2;
        }
        
    
    
    int tag = _curSheet.tag;
    [self showIndicate];
    [UIImage uploadImage:imga size:size blk:^(BOOL suc, NSData *dic) {
        [self hideIndicate];
        if(suc){
           // int tag = _curSheet.tag;
            AsynBaseModel * model = [[AsynBaseModel alloc] initWithData:dic];
            if ([model valueForKey:@"data"]) {
                NSDictionary * d = [model valueForKey:@"data"];
                if (tag == 0) {
                   // thisUser.AvatarUrl =[d valueForKey:@"imageUrl"];
                    //thisUser.AvatarId =[d valueForKey:@"pictureId"];
                    _c1.image = imga;
                    m1 = model;
                }else if (tag == 1){
                    _c2.image = imga;
                    m2 = model;
                }else{
                    _c3.image = imga;
                    m3 = model;
                }
                [NWFToastView showToast:@"上传成功"];
                
            }else{
                [NWFToastView showToast:@"上传失败"];
                
            }
            
            
        }else{
            [NWFToastView showToast:@"上传失败"];
        }
        
    }];
    
    
}


/**
 *  图片压缩
 */
- (UIImage*)imageWithImage:(UIImage*)image11 scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image11 drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
}


@end
