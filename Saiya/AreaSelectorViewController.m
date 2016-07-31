//
//  AreaSelectorViewController.m
//  Saiya
//
//  Created by zougyor on 16/7/31.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "AreaSelectorViewController.h"
#import "AreaModel.h"
@interface AreaSelectorViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray * _regions;
    NSArray * _citys,*_distric;
}
@end

@implementation AreaSelectorViewController
-(void)dealloc{
    [_piker removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _regions = [NSMutableArray array];
    _filed.delegate = self;
    //每个btn 35 30
    float x = 30;
    float curX = x;
    float w = 55;
    float h = 25;
    float curY = 0;
    float gap = 10;
    for (AreaModel * model in _areasData) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (curX + w > SCREENWIDTH - 10) {
            curX = x;
            curY += h + 5;
        }
        CGRect frame = CGRectMake(curX, curY, w, h);
        
        curX += w + gap;
        btn.frame = frame;
        btn.clipsToBounds = YES;
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        btn.layer.cornerRadius = 3;
        btn.layer.borderWidth = 1;
        btn.titleLabel.textColor = [UIColor blackColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:model.Name forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickArea:) forControlEvents:UIControlEventTouchUpInside];
        [self.areas addSubview:btn];
        btn.tag = [_areasData indexOfObject:model];
    }
    _contentHeight.constant = curY + 10;
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped)];
    [self.view addGestureRecognizer:ges];
    
    _piker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 216, SCREENWIDTH, 216)];
    _piker.backgroundColor = [UIColor whiteColor];
    [self.view.window addSubview:_piker];
    
    _piker.hidden = YES;
    
    _piker.dataSource = self;
    _piker.delegate = self;
}
-(void)taped
{
 
   
    if ([self.filed isFirstResponder] || _piker.hidden == NO) {
        [self.view endEditing:YES];
        _piker.hidden = YES;
    }else{
        _doSearchBlk(nil);
        [_piker removeFromSuperview];
    }
}
-(void) clickArea:(UIButton*)btn
{
    NSNumber * Id = [_areasData[btn.tag] Id];
    if (_doSearchBlk) {
        _doSearchBlk([NSString stringWithFormat:@"%@",Id]);
    }

}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _piker.hidden=YES;
    [_regions removeAllObjects];
    [_c1 setTitle:@"省份" forState:UIControlStateNormal];
    [_c2 setTitle:@"城市" forState:UIControlStateNormal];
    [_c3 setTitle:@"区域" forState:UIControlStateNormal];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)doSearch:(id)sender
{
    [_piker removeFromSuperview];
    if (_doSearchBlk) {
        if (_filed.text.length > 0) {
            _doSearchBlk(_filed.text);
        }else{
            _doSearchBlk([_regions componentsJoinedByString:@","]);
        }
    }
}
-(IBAction)doSelect:(UIButton*)sender
{
    [self.view endEditing:YES];
    [_piker removeFromSuperview];
    _piker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 216, SCREENWIDTH, 216)];
    _piker.backgroundColor = [UIColor whiteColor];
    [self.view.window addSubview:_piker];
    

    
    _piker.dataSource = self;
    _piker.delegate = self;
    
    
    _piker.hidden = NO;
    //[self.view.window addSubview:_piker];
    _piker.tag = sender.tag;
    //找到选中的
    long index = 0;
    if (sender.tag < _regions.count) {
        AreaModel * model = _regions[sender.tag];
        if(sender.tag == 0 ){
            index = [_statesData indexOfObject:model]+1;
        }else if (sender.tag == 1){
            index = [_citys indexOfObject:model]+1;
        }else{
            index = [_distric indexOfObject:model]+1;
        }
    }

    [_piker selectRow:index inComponent:0 animated:NO];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[_piker reloadAllComponents];
    });
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag==0) {
        return _statesData.count +1;
    }else if (pickerView.tag==1){
        return _citys.count+1;
    }else{
         return    _distric.count+1;
    }
        
    return 20;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 33;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray * arr = nil;
    NSArray * t = @[@"省份",@"城市",@"区域"];
    if (row == 0) {
        return t[pickerView.tag];
    }
    if (pickerView.tag==0) {
        arr = _statesData;
    }else if (pickerView.tag==1){
        arr = _citys;
    }else{
        arr=    _distric;
    }
    AreaModel * model = arr[row-1];
    return model.Name;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row == 0) {
      //  NSArray * t = @[@"省份",@"城市",@"区域"];
        long count = _regions.count;
        if (pickerView.tag == 0) {
            [_regions removeAllObjects];
            [_c1 setTitle:@"省份" forState:UIControlStateNormal];
            [_c2 setTitle:@"城市" forState:UIControlStateNormal];
            [_c3 setTitle:@"区域" forState:UIControlStateNormal];
        }else if (pickerView.tag == 1){
            for (int i = 1; i<count; i++) {
                [_regions removeObjectAtIndex:i];
            }
            [_c2 setTitle:@"城市" forState:UIControlStateNormal];
            [_c3 setTitle:@"区域" forState:UIControlStateNormal];
        }else{
            for (int i = 2; i<count; i++) {
                [_regions removeObjectAtIndex:i];
            }
           // [_c2 setTitle:@"城市" forState:UIControlStateNormal];
            [_c3 setTitle:@"区域" forState:UIControlStateNormal];
        
        }
        return;
    }
    NSArray * arr = nil;
    UIButton * btn;
    if (pickerView.tag==0) {
        arr = _statesData;
        if (arr.count < row) {
            return;
        }
        btn = _c1;
        [_c2 setTitle:@"城市" forState:UIControlStateNormal];
        [_c3 setTitle:@"区域" forState:UIControlStateNormal];
        [_regions removeAllObjects];
        AreaModel * model = arr[row-1];
        [self getCityByStateID:model.Id];
        [_c3 setTitle:@"区域" forState:UIControlStateNormal];
        
    }else if (pickerView.tag==1){
        arr = _citys;
        btn = _c2;
        if (arr.count < row) {
            return;
        }
        id obj = [_regions firstObject];
        if (obj) {
            [_regions removeAllObjects];
            [_regions addObject:obj];
        }
        AreaModel * model = arr[row-1];
        [self getDisctriByCId:model.Id];
        
    }else{
        arr=    _distric;
        btn = _c3;
        if (arr.count < row) {
            return;
        }
        if (_regions.count>2) {
            [_regions removeLastObject];
        }
      
    }
    AreaModel * model = arr[row-1];
    [btn setTitle:model.Name forState:UIControlStateNormal];

    [_regions addObject:model];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)getCityByStateID:(NSNumber*)cid
{
    NSString* root = @"http://saiya.tv/API/Common/GetCitysByStateId?stateId=";
    NSString * url = [NSString stringWithFormat:@"%@%@",root,cid];
    [[NetworkManagementRequset manager] requestGet:url complation:^(BOOL result, id returnData, id cookieData) {
        if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
            NSArray * datas = returnData[@"data"];
            NSMutableArray * temp = [NSMutableArray array];
            for (NSDictionary * dict in datas) {
                AreaModel * model = [[AreaModel alloc] initWithAtrribute:dict];
                [temp addObject:model];
                
            }
            _citys = temp;
            [_piker reloadAllComponents];
    
        }

        
    }];
    
    
}
-(void)getDisctriByCId:(NSNumber*)cid
{
    NSString* root = @"http://saiya.tv/API/Common/GetDistrictsByCityId?cityId=";
    NSString * url = [NSString stringWithFormat:@"%@%@",root,cid];
    [[NetworkManagementRequset manager] requestGet:url complation:^(BOOL result, id returnData, id cookieData) {
        if (result && [[returnData objectForKey:@"result"] boolValue] == YES) {
            NSArray * datas = returnData[@"data"];
            NSMutableArray * temp = [NSMutableArray array];
            for (NSDictionary * dict in datas) {
                AreaModel * model = [[AreaModel alloc] initWithAtrribute:dict];
                [temp addObject:model];
                
            }
            _distric = temp;
            [_piker reloadAllComponents];

        }

        
    }];
    
}
@end
