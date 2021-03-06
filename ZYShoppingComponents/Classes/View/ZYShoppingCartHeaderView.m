//
//  ZYShoppingCartHeardView.m
//  ShoppingComponents_Example
//
//  Created by Apple on 2020/11/2.
//  Copyright © 2020 xiaoyang521style. All rights reserved.
//

#import "ZYShoppingCartHeaderView.h"
#import "ZYShoppingHeader.h"
#import <ZYUnderlyingComponents/UIColor+ZYHex.h>


@interface ZYShoppingCartHeaderView ()


@property(nonatomic,assign)NSInteger section ;
@property(nonatomic,copy)NSMutableArray *carDataArrList;

@end

@implementation ZYShoppingCartHeaderView
- (instancetype)initWithFrame:(CGRect)frame section :(NSInteger )section carDataArrList:(NSMutableArray *)carDataArrList block:(void (^)(UIButton *))blockbt {
    self =  [super initWithFrame:frame];
    if (self) {
        _section= section;
        _carDataArrList = carDataArrList;
        _blockBT = blockbt;
        [self initView];
    }
    return self;
}

- (void )initView
{
    NSString  *bundlePath = [[NSBundle mainBundle] pathForResource:@"Frameworks/ZYShoppingComponents.framework/ZYShoppingComponents" ofType:@"bundle"];
    UIImage *btimg = [UIImage imageWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"Unselected.png"]];
    UIImage *selectImg =  [UIImage imageWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"Selected.png"]];
    UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(2, 5, btimg.size.width+12, btimg.size.height+10)];
    bt.tag = 100+_section;
    [bt addTarget:self action:@selector(clickAll:) forControlEvents:UIControlEventTouchUpInside];
    [bt setImage:btimg forState:UIControlStateNormal];
    [bt setImage:selectImg forState:UIControlStateSelected];
    [self addSubview:bt];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bt.frame)+15, 0, 90,40)];
    lab.textColor=[UIColor colorWithHexString:@"666666"];
    lab.font=[UIFont systemFontOfSize:16];
    NSArray *list  = [self.carDataArrList objectAtIndex:_section];

    
    NSMutableDictionary *dic = [list lastObject];
    
    if ([@"YES" isEqualToString:[dic objectForKey:@"checked"]]) {
        bt.selected=YES;
    }
    else if ([@"NO" isEqualToString:[dic objectForKey:@"checked"]])
    {
        bt.selected=NO;
    }
    
    NSInteger dicType = [[dic objectForKey:@"type"] integerValue];
    
    
    [self addSubview:lab];
    
    if (_section==0) {
        self.frame=CGRectMake(0, 0, APPScreenWidth, 50);
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPScreenWidth, 10)];
        view.backgroundColor=[UIColor colorWithHexString:@"e2e2e2"];
        [self addSubview:view];
        
        bt.frame=CGRectMake(bt.frame.origin.x, bt.frame.origin.y+10, bt.frame.size.width, bt.frame.size.height);
        lab.frame =CGRectMake(lab.frame.origin.x, lab.frame.origin.y+10, lab.frame.size.width, lab.frame.size.height);
    }
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame), lab.frame.origin.y, APPScreenWidth-CGRectGetMaxX(lab.frame)-70, lab.frame.size.height)];
    lab1.font=[UIFont systemFontOfSize:15];
    lab1.textColor=[UIColor colorWithHexString:@"f5a623"];
    [self addSubview:lab1];
    
    if (dicType ==1) {
        lab.text=@"商品标题1";
    }
    else if (dicType ==2)
    {
        lab.text=@"商品标题2";
    }
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, APPScreenWidth, 0.5)];
    line.backgroundColor=[UIColor colorWithHexString:@"e2e2e2"];
    [self addSubview:line];
    

}
-(void)clickAll:(UIButton *)bt
{
    _blockBT(bt);
}


- (void)dealloc
{
    NSLog(@"消失header了");
}
@end
