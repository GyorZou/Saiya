//
//  MineInfoPage.m
//  Saiya
//
//  Created by jp007 on 16/6/23.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "MineInfoPage.h"
#import "MyHeadCell.h"
#import "SaiyaUser.h"
#import "GoodsDetailTitle.h"
#import "ProfileController.h"
#import "NoneBarWebviewController.h"
#import "SaiyaSearchController.h"
#import "IWantAuthentication.h"
#import "MySaidouViewController.h"
#import "CustomerContent.h"
#import "QRCodeGenerator.h"
#import "ShowProfileViewController.h"

@interface MineInfoPage ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    UITableView * _contentView;
    NSArray * _datas;
    UIImage * _placeHolderImage;
}
@end

@implementation MineInfoPage
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[SaiyaUser curUser] reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.tabBarItem.image = [[UIImage imageNamed:@"icon-nav4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon-nav4-visited"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _contentView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_contentView];
    _contentView.delegate = self;
    _contentView.dataSource = self;
    
    //_placeHolderImage = [UIImage imageNamed:@"icon-nav4-visited"];
    [_contentView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"infocell2"];
    [_contentView registerNib:[UINib nibWithNibName:@"MyHeadCell" bundle:nil] forCellReuseIdentifier:@"infocell1"];
    
    NSDictionary * a1 = @{@"image":@"heart",@"title":@"我的关注",@"class":@"",@"url":@"watchings.html"};
    NSDictionary * a2 = @{@"image":@"trophy",@"title":@"我的赛事",@"class":@"InfoDetailViewController",@"url":@"mycompetion.html"};
    NSDictionary * a3 = @{@"image":@"authentication",@"title":@"我要认证",@"class":@"IWantAuthentication",@"url":@""};

    NSDictionary * a4 = @{@"image":@"saidou",@"title":@"赛豆",@"class":@"MySaidouViewController",@"url":@""};

    NSDictionary * a5 = @{@"image":@"shezhi",@"title":@"设置",@"class":@"",@"url":@""};

    
    _datas = @[a1,a2,a3,a4,a5];
    
    [self initTitleview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo) name:[SaiyaUser notificationString] object:nil];
    
}
-(void)updateUserInfo
{
    [_contentView reloadData];
}
-(void)initTitleview
{
    
    GoodsDetailTitle *title =[[GoodsDetailTitle alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    title.selectedTitleColor = [UIColor whiteColor];
    title.unselectedTitleColor = APPCOLOR_GRAY;
    
    
    title.titles=@[@"我的"];
    
    
    self.navigationItem.titleView=title;
    //self.navigationItem.rightBarButtonItem = [self rightItem];
    
    
}
-(UIBarButtonItem *)backItem
{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    
    [backBtn addTarget:self action:@selector(searchItemClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"icon-search"] forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];;
}
-(void)searchItemClick
{
    SaiyaSearchController * s  = [SaiyaSearchController new];
    s.baseUrl = @"http://saiya.tv/h5/search.html";
    [self.navigationController pushViewController:s animated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return _datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    if (indexPath.section == 0) {
        MyHeadCell * myHead = [tableView dequeueReusableCellWithIdentifier:@"infocell1"];
        UIImage  * image = _placeHolderImage;
        SaiyaUser * user = [SaiyaUser curUser];
        NSURL * url = [NSURL URLWithString:user.AvatarUrl ];
        
        if (_placeHolderImage) {
            myHead.headImgeView.image = _placeHolderImage;
        }else{
            [myHead.headImgeView setImageWithURL:url placeholderImage:image];
        }
        myHead.headImgeView.layer.cornerRadius = myHead.headImgeView.frame.size.width/2;
        myHead.headImgeView.clipsToBounds = YES;
        
        myHead.nameLabel.text = user.Username;
        myHead.saidouLabel.text = [NSString stringWithFormat:@"赛豆:%@颗",user.RewardPoints];
        NSString *c = [NSString stringWithFormat:@"%@",user.Id];
        myHead.countLabel.text = APPENDSTRING(@"赛芽号:", c);
        
        myHead.clipsToBounds = YES;
        myHead.headImgeView.layer.cornerRadius = myHead.headImgeView.frame.size.width/2;
        myHead.QRCodeBlk =^{
           UIImage * img = [QRCodeGenerator generateQRCode:c width:SCREENWIDTH/2];
            UIImageView *view =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH/2, SCREENWIDTH/2)];
            view.image = img;
            [CustomerContent showView:view];
        
        };
        myHead.headBlk = ^{
            [self photoImgButtonPressed];
        };
        cell = myHead;
        
    }else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"infocell2"];
        cell.detailTextLabel.text = nil;
        if (indexPath.row == 3) {
            SaiyaUser * user = [SaiyaUser curUser];
            cell.detailTextLabel.text =[NSString stringWithFormat:@"%@颗",user.RewardPoints];// @"1001颗";
            cell.detailTextLabel.textColor =APPCOLOR_ORINGE;
        }
        cell.textLabel.text = _datas[indexPath.row][@"title"];
        cell.imageView.image = [UIImage imageNamed:_datas[indexPath.row][@"image"]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 107;
    }
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }
    return 20;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([LoginPage showIfNotLogin] == YES) {
        if (indexPath.section == 0) {
            ShowProfileViewController * p = [ShowProfileViewController new];
            p.title = @"个人信息";
            [self.navigationController pushViewController:p animated:YES];
        }else{
            
            NSString * root = @"http://saiya.tv/h5/";
            NSDictionary * dict =  _datas[indexPath.row];
            
            NSString * cls = dict[@"class"];
            NSString * url = dict[@"url"];
            NSString * title = dict[@"title"];
            if (url.length > 0) {
                url = [root stringByAppendingString:url];
            }
            UIViewController * destin;
            if (cls.length > 0) {
                UIViewController * vc = [NSClassFromString(cls) new];
                if (url.length > 0) {
                    [vc setValue:url forKey:@"baseUrl"];
                    [vc setValue:@(YES) forKey:@"hideNaviBar"];
                    destin.view.backgroundColor = APPCOLOR_ORINGE;
                }
                destin = vc;
            }else{
                BaseWebviewController * base = [[NoneBarWebviewController alloc] init];
                if (url.length == 0) {
                    url = [root stringByAppendingString:@"watchings.html"];
                }
                base.baseUrl = url;
                destin = base;
                base.hideNaviBar = YES;
                destin.view.backgroundColor = APPCOLOR_ORINGE;
            }
            
            destin.title = title;
            destin.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:destin animated:YES];

        }
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)photoImgButtonPressed{
    
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
    [actionSheet showInView:self.view];
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
    _placeHolderImage = imga;
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {// 保存到手机相册
        UIImageWriteToSavedPhotosAlbum(imga, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    __block UIImage* postImage = imga;
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSString *string =@"http://saiya.tv/api/AsyncUpload/AsyncPictureUpload";// [[NSString alloc] initWithFormat:@"%@?u=%@",[WJAppConfig urlForEnumKey:WJUrlKeyLogoUpdate],SessionId[@"userId"]];
    CGSize   size = imga.size;
    float rate = size.width / size.height;
    if (size.width > 100) {
        size.width = 100;
        size.height = 100/rate;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    
    [imga drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //imga = [imga imageWithResize:size];
    NSString * ids =[NSString stringWithFormat:@"%@", [SaiyaUser curUser].Id];
    imga = reSizeImage;
    //__weak MineInfoPage *weakSelf = self;
    [[NetworkManagementRequset defaultManager] requestPhoto:string cookieString:ids postPhotoImg:UIImagePNGRepresentation(imga) complation:^(BOOL result, id returnData) {
        if(result){
            
            AsynBaseModel * model = [[AsynBaseModel alloc] initWithData:returnData];
            [NWFToastView showToast:@"头像上传成功"];
            postImage = [self imageWithImage:postImage scaledToSize:CGSizeMake(200, 200)];
            //weakSelf.photoImg.image = postImage;
            [_contentView reloadData];
        }else{
            [NWFToastView showToast:@"头像上传失败"];
        }
    }];
    [_contentView reloadData];
    
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
