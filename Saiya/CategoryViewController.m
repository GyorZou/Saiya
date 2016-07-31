//
//  CategoryViewController.m
//  Saiya
//
//  Created by zougyor on 16/7/31.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "CategoryViewController.h"
#import "AreaModel.h"
@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    float x = 10;
    float curX = x;
    float w = 55;
    float h = 25;
    float curY = 10;
    float gap = 10;
    UIView * view = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:view];
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
        [view addSubview:btn];
        btn.tag = [_areasData indexOfObject:model];
    }

    view.frame = CGRectMake(0, 0, SCREENWIDTH, curY + 10 + h);
    view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped)];
    [self.view addGestureRecognizer:ges];
}
-(void)taped
{

    _doSearchBlk(nil);
   
}
-(void) clickArea:(UIButton*)btn
{
    NSNumber * Id = [_areasData[btn.tag] Id];
    if (_doSearchBlk) {
        _doSearchBlk([NSString stringWithFormat:@"%@",Id]);
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

@end
