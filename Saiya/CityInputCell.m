//
//  CityInputCell.m
//  Saiya
//
//  Created by jp007 on 16/8/1.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "CityInputCell.h"
#import "AreaModel.h"
@implementation CityInputCell

- (void)awakeFromNib {
    // Initialization code
    _f1.delegate =_f2.delegate =_f3.delegate = self;
    UIPickerView * pick = [[UIPickerView alloc] init];
    pick.frame =CGRectMake(0, 0, SCREENWIDTH, 216);
    pick.dataSource = self;
    pick.delegate = self;
    _f1.inputView = _f2.inputView = _f3.inputView = pick;
    _piker = pick;
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
        return  3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:{
            
            return _states.count+1;
        }
            break;
        case 1:{
            
            return _citys.count+1;
        }
            break;
        case 2:{
          
            return _distris.count+1;
        }
    }

    return 10;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    switch (component) {
        case 0:{
            if(row == 0) return @"省份";
            AreaModel *m =  _states[row-1];
            return m.Name;
        }
            break;
        case 1:{
            if(row == 0) return @"城市";
            AreaModel *m =  _citys[row-1];
            return m.Name;
        }
            break;
        case 2:{
            if(row == 0) return @"区域";
            AreaModel *m =  _distris[row-1];
            return m.Name;
        }
            break;
            
        default:
            break;
    }
    return @"xx";
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:{
          
           _f1.text = @"省份";
            if (row != 0) {
                AreaModel *m =  _states[row-1];
                _f1.text = m.Name;
                _user.StateProvinceId = m.Id;
               [self getCityByStateID:m.Id];
            }
            
            _f2.text = @"城市";
            _f3.text = @"区域";
        }
            break;
        case 1:{
           _f2.text = @"城市";;
            if (row != 0) {
                AreaModel *m =  _citys[row-1];
                _f2.text = m.Name;
                _user.CityId = m.Id;
               [self getDisctriByCId:m.Id];
            }
            
            _f3.text = @"区域";
        }
            break;
        case 2:{
            _f3.text = @"区域";
             if (row != 0) {
                 AreaModel *m =  _distris[row-1];
                 _user.DistrictId = m.Id;
                 _f3.text = m.Name;
             }
            
        }
            break;
            
        default:
            break;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


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
            [_piker reloadComponent:1];
            
            NSNumber * p = _user.StateProvinceId;
            NSNumber * p2 = _user.CityId;
            NSNumber * p3 = _user.DistrictId;
            if (p2) {
                [temp enumerateObjectsUsingBlock:^(AreaModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.Id isEqual:p2]) {
                        _f2.text = obj.Name;
                        [self getDisctriByCId:p2];
                    }
                    
                }];
            }
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
            _distris = temp;
            [_piker reloadComponent:2];
            
           
            NSNumber * p3 = _user.DistrictId;
            if (p3) {
                [temp enumerateObjectsUsingBlock:^(AreaModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.Id isEqual:p3]) {
                        _f3.text = obj.Name;
                    }
                    
                }];
            }

            
        }
        
        
    }];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSNumber * p = _user.StateProvinceId;
    NSNumber * p2 = _user.CityId;
    NSNumber * p3 = _user.DistrictId;
    
    if (p) {
        __block int index=0,index2=0,index3=0;
        [_states enumerateObjectsUsingBlock:^(AreaModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.Id isEqual:p]) {
                _f1.text = obj.Name;
                if (p2) {//通过
                    [self getCityByStateID:p];
                    
                }
            }
            
        }];
    }
}

@end
