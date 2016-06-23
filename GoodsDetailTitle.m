//
//  GoodsDetailTitle.m
//  ewj
//
//  Created by jp007 on 15/8/11.
//  Copyright (c) 2015年 cre.crv.ewj. All rights reserved.
//

#import "GoodsDetailTitle.h"

@interface GoodsDetailTitle ()
{
    int _index;
    NSMutableArray * _actionBtns;
    UIView * _line;

}
@end

@implementation GoodsDetailTitle

-(void)setTitles:(NSArray *)titles
{
    _selectedTitleFont = [UIFont systemFontOfSize:17];
    _unselectedTitleFont = [UIFont systemFontOfSize:15];
    _titles=titles;
    if (_actionBtns == nil) {
        _actionBtns =[NSMutableArray array];
    }
  
    self.userInteractionEnabled= _titles.count>0;;
 
    
    [_actionBtns removeAllObjects];
    
    int i=0;
    for (NSString * title in _titles) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.text=title;
       
        [_actionBtns addObject:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(actionBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        i++;
        [self addSubview:btn];
       
        btn.titleLabel.font=[UIFont systemFontOfSize:17];
    }
    [self setNeedsLayout];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)actionBtnClicked:(UIButton *)btn
{
    int newIndex = (int)btn.tag;
    int old =_index;
    if (newIndex ==old) {
        return;
    }
    [self setIndex:newIndex];
    if (_indexChangeBlock) {
        _indexChangeBlock(old,newIndex);
    }
}
-(void)setIndex:(int)index
{
    if (index  == _index) {
        return;
    }
    
    
    [UIView animateWithDuration:.25 animations:^{
    
        //
    }];

    _index = index;
    [self performSelector:@selector(setNeedsLayout) withObject:nil afterDelay:.05];
  

}
-(void)layoutSubviews
{
    int i =0;
    if (_selectedTitleColor == nil) {
       // _selectedTitleColor = kEWJNavgationBarTitleColor; //[UIColor blackColor];
        _selectedTitleColor = [UIColor blackColor];
        
    }
    
    if (_unselectedTitleColor == nil) {
      //  _unselectedTitleColor = kEWJNavgationBarDselectTitleColor;//[UIColor lightGrayColor];
        _unselectedTitleColor = [UIColor lightGrayColor];
        
    }
    int count =MAX(1, (int)_titles.count);
    
    float w =self.frame.size.width/count;
 
    for (NSString * title in _titles) {
        UIButton * btn = _actionBtns[i];
        
        btn.selected = i==_index;
        btn.titleLabel.text=title;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:_selectedTitleColor forState:UIControlStateSelected];
        [btn setTitleColor:_unselectedTitleColor forState:UIControlStateNormal];
        if (btn.selected == YES) {
            btn.titleLabel.font = _selectedTitleFont;
        }else{
            btn.titleLabel.font = _unselectedTitleFont;
        }
        btn.frame =CGRectMake(i*w, 0, w, self.frame.size.height);
        i++;
    }

    
    [super layoutSubviews];
}

-(void)BtnNotToClick{
 
    for (UIButton *btn in _actionBtns) {
        btn.userInteractionEnabled = NO;
    }
}
@end
