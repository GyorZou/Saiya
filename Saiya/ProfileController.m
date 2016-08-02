//
//  ProfileController.m
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "AreaModel.h"

#import "ProfileController.h"
#import "InputTableViewCell.h"

#import "SaveTableViewCell.h"
#import "MySignatureTableViewCell.h"
#import "ImagesTableViewCell.h"
#import "CityInputCell.h"
#import "HeaderTableViewCell.h"
@interface ProfileController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    BOOL _editing;
    NSArray * _states;
    UIActionSheet * _curSheet;
    NSMutableArray * imageUrls;
    NSMutableArray * holders;
    NSMutableArray * imageIds;
    ImagesTableViewCell * _curHeader;
    SaiyaUser * thisUser;
}
@end

@implementation ProfileController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _tableView.frame = self.view.bounds;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource= self;
    thisUser = [[SaiyaUser curUser] copiedUser];
    imageUrls = [NSMutableArray     array];
    imageIds = [NSMutableArray array];
    holders = [NSMutableArray array];
    [thisUser.Pictures enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [imageUrls addObject:[obj objectForKey:@"Url"]];
        [imageIds addObject:[obj objectForKey:@"Id"]];
    }];
    
    [self.view addSubview:_tableView];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_tableView registerNib:[UINib nibWithNibName:@"InputTableViewCell" bundle:nil] forCellReuseIdentifier:@"InputTableViewCell.h"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MySignatureTableViewCell" bundle:nil] forCellReuseIdentifier:@"MySignatureTableViewCell.h"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ImagesTableViewCell" bundle:nil] forCellReuseIdentifier:@"ImagesTableViewCell.h"];
    //#import "CityInputCell.h"#import "HeaderTableViewCell.h"
    
    [_tableView registerNib:[UINib nibWithNibName:@"CityInputCell" bundle:nil] forCellReuseIdentifier:@"CityInputCell.h"];
    [_tableView registerNib:[UINib nibWithNibName:@"HeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"HeaderTableViewCell.h"];
    _editing = YES;
    //[self showEdit];
    [self loadStates];
    [[SaiyaUser curUser] reloadData];
    
}
-(void)showEdit
{
     _editing = NO;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 25);
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(editView) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

}
-(void)editView
{
//    self.navigationItem.rightBarButtonItem = nil;
//    _editing = YES;
//    [_tableView reloadData];
    [self.navigationController pushViewController:[ProfileController new] animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return SCREENWIDTH*0.6;
    }else if (indexPath.row == 1){
        return 60;
    }else if (indexPath.row == 9){
        return 130;
    }
    return 40;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    NSArray  *titles =@[@"头像",@"姓名",@"性别",@"年龄",@"地区",@"情感状态",@"签名",@"微博"];
    
    
     NSArray  *keys =@[@"x",@"AvatarUrl",@"Username",@"Gender",@"Old",@"Address",@"EmotionalState",@"Signature",@"Weibo",@"Description"];
    
    SaiyaUser * user = thisUser;//[SaiyaUser curUser];
    id value =  [user valueForKey:keys[indexPath.row]];
    NSString * string = NSStringFromObject(value);
    if ([string isEqualToString:@"<null>"]) {
        string = @"";
    }
    if (indexPath.row == 0) {
       ImagesTableViewCell*  cell1 = [tableView dequeueReusableCellWithIdentifier:@"ImagesTableViewCell.h"];
        _curHeader = cell1;

        cell1.deleteBtn.hidden = imageUrls.count == 0;
        cell1.addBtn.hidden = imageUrls.count == 3;
        __weak ImagesTableViewCell * wc = cell1;
        cell1.deleteBlk = ^{
            EScrollerView * es = wc.imageViews;
            int index = es.curIndex - 1;
            [imageIds removeObjectAtIndex:index];
            [imageUrls removeObjectAtIndex:index];
            //[holders removeObjectAtIndex:index];
            [_tableView reloadData];
            //删除
        };
        
        cell1.addBlk =^{
            UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
            
           // btn.tag =
            [self photoImgButtonPressed:5];
        };
        
        [cell1.imageViews ImageArray:imageUrls TitleArray:nil rect:CGRectZero isBanner:NO];
        cell = cell1;
    }else if (indexPath.row == 1){
        //HeaderTableViewCell.h
        cell= [tableView dequeueReusableCellWithIdentifier:@"HeaderTableViewCell.h"];
        HeaderTableViewCell * cell1 = cell;
        [cell1.headImage setImageWithURL:[NSURL URLWithString:user.AvatarUrl] placeholderImage:[UIImage imageNamed:@"icon-user"]];
        
        cell1.headImage.clipsToBounds = YES;
        cell1.headImage.layer.cornerRadius = cell1.headImage.frame.size.width/2;
        cell1.headBlk = ^{
            [self photoImgButtonPressed:10];
        };
        cell.userInteractionEnabled = _editing == YES;
        
    }else if (indexPath.row == 9){
    //HeaderTableViewCell.h
      MySignatureTableViewCell *  cell1= [tableView dequeueReusableCellWithIdentifier:@"MySignatureTableViewCell.h"];
        cell = cell1;
        
        cell1.user = thisUser;
        cell.userInteractionEnabled = _editing == YES;
        UILabel * label = [cell valueForKey:@"infoLabel"];
        label.text = string;

    }else if (indexPath.row == 5){
        
       CityInputCell *  cell1= [tableView dequeueReusableCellWithIdentifier:@"CityInputCell.h"];
        cell1.states = _states;
        cell1.user = thisUser;
        cell = cell1;
        UILabel * label = [cell valueForKey:@"titleLabel"];
        label.text = titles[indexPath.row - 1];
        cell.userInteractionEnabled = _editing == YES;
        
        
    }else{
       InputTableViewCell * cell1= [tableView dequeueReusableCellWithIdentifier:@"InputTableViewCell.h"];
        cell = cell1;
        cell1.user = thisUser;
        UILabel * label = [cell valueForKey:@"titleLabel"];
        label.text = titles[indexPath.row - 1];
        cell.userInteractionEnabled = _editing == YES;
        label = [cell valueForKey:@"infoLabel"];
        label.text = string;

    }
    
 
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return _editing?60:0.1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view;
    if (_editing) {
        SaveTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"SaveTableViewCell" owner:nil options:nil] lastObject];//[SaveTableViewCell new];
        cell.saveBlk = ^{
            
        };
        view = cell;
        view.frame = CGRectMake(0, 0, SCREENWIDTH, 60);
    }
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadStates
{
    NSString* root = @"http://saiya.tv/API/Common/GetStates";
    
    [[NetworkManagementRequset manager] requestGet:root complation:^(BOOL result, id returnData, id cookieData) {
        if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
            NSArray * datas = returnData[@"data"];
            NSMutableArray * temp = [NSMutableArray array];
            for (NSDictionary * dict in datas) {
                AreaModel * model = [[AreaModel alloc] initWithAtrribute:dict];
                [temp addObject:model];
                
            }
            _states = temp;
            [_tableView reloadData];

        }
        
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
    if (_curSheet.tag == 10) {//头像
        float rate = size.width / size.height;
        if (size.width > 100) {
            size.width = 100;
            size.height = 100/rate;
        }

    }else{
        if (size.width > 1000) {
            size.width = size.width/2;
            size.height = size.height/2;
        }
    
    }
    
    
    [self showIndicate];
    [UIImage uploadImage:imga size:size blk:^(BOOL suc, NSData *dic) {
        [self hideIndicate];
        if(suc){
            int tag = _curSheet.tag;
            AsynBaseModel * model = [[AsynBaseModel alloc] initWithData:dic];
            if ([model valueForKey:@"data"]) {
                NSDictionary * d = [model valueForKey:@"data"];
                if (tag==10) {
                    thisUser.AvatarUrl =[d valueForKey:@"imageUrl"];
                    thisUser.AvatarId =[d valueForKey:@"pictureId"];
                }else{
                    /*
                     
                     */
                    
                    [imageUrls addObject:[d valueForKey:@"imageUrl"]];
                    [imageIds addObject:[d valueForKey:@"pictureId"]];
                    
                }
                [_tableView reloadData];
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
-(void)saveInfo
{
    NSString* root = @"http://saiya.tv/api/customer/SaveInfo";
    [self showIndicate];
    [[NetworkManagementRequset manager]  requestPostData:root postData:nil complation:^BOOL(BOOL result, id returnData) {
        [self hideIndicate];
        if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
            [NWFToastView showToast:@"保存成功"];
        }else{
            [NWFToastView showToast:@"保存失败"];

        }

    
        return YES;
    }];
    

}
@end
