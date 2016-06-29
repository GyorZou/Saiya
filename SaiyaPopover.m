//
//  SaiyaPopover.m
//  Saiya
//
//  Created by jp007 on 16/6/29.
//  Copyright © 2016年 crv. All rights reserved.
//

#import "SaiyaPopover.h"

@interface SaiyaPopover ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * _items;
    //void (^_blk)(int);
}
@property (nonatomic,copy)  void (^blk)(int) ;

@end

@implementation SaiyaItem

+(id)itemWithTitle:(NSString *)ti image:(NSString *)image
{
    SaiyaItem * item = [[[self class] alloc] init];
    item.title = ti;
    item.image = image;
    return item;
    
}
@end

@implementation SaiyaPopover

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(void)showAt:(CGPoint)p withItems:(NSArray *)items inView:(UIView *)v block:(void (^)(int))blk
{

    SaiyaPopover * popover = [SaiyaPopover new];
    
    popover.blackOverlay.backgroundColor = [UIColor lightGrayColor];
    popover.cornerRadius = 0;
    
    
    float w = 180;
    
    for (SaiyaItem * item in items) {
        NSString * s = item.title;
        CGSize size = [s sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(3000, 30)];
        
        w = MAX(w,size.width + 90);
    }
    popover -> _items  = items;
    popover.blk = blk;
    UITableView *tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, w, items.count*40) style:UITableViewStylePlain];
    tableView.rowHeight=40;
    tableView.delegate= popover;
    tableView.dataSource= popover;
    tableView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.6];
    tableView.scrollEnabled = NO;
    tableView.separatorColor = [UIColor blackColor];

    popover.contentInset = UIEdgeInsetsZero;
    popover.maskType=DXPopoverMaskTypeClear;
    popover.backgroundColor=[UIColor lightGrayColor];
    popover.arrowSize = CGSizeZero;
    
    [popover showAtPoint:p
               popoverPostion:DXPopoverPositionDown
              withContentView:tableView
                       inView:v];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    SaiyaItem * item = _items[indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = item.title;
    cell.imageView.image = [UIImage imageNamed: item.image];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismiss];
    if (_blk) {
        _blk(indexPath.row);
    }

    
}
@end
