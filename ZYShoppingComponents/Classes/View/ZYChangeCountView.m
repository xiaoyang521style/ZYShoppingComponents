//
//  ZYChangeCountView.m
//  ShoppingComponents_Example
//
//  Created by Apple on 2020/11/2.
//  Copyright © 2020 xiaoyang521style. All rights reserved.
//

#import "ZYChangeCountView.h"
#import <ZYUnderlyingComponents/UIColor+ZYHex.h>
@implementation ZYChangeCountView

- (instancetype)initWithFrame:(CGRect)frame chooseCount:(NSInteger)chooseCount totalCount:(NSInteger)totalCount
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        self.choosedCount = chooseCount;
        self.totalCount = totalCount;
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    _subButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    NSString  *bundlePath = [[NSBundle mainBundle] pathForResource:@"Frameworks/ZYShoppingComponents.framework/ZYShoppingComponents" ofType:@"bundle"];
 
    
    _subButton.frame = CGRectMake(0, 0, [UIImage imageWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"product_detail_sub_normal.png"]].size.width, [UIImage imageWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"product_detail_sub_normal.png"]].size.height);
    
    
    [_subButton setBackgroundImage:[UIImage imageWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"product_detail_sub_normal.png"]] forState:UIControlStateNormal];
    [_subButton setBackgroundImage:[UIImage imageWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"product_detail_sub_no.png"]] forState:UIControlStateDisabled];
    
    _subButton.exclusiveTouch = YES;
    [self addSubview:_subButton];
    if (self.choosedCount <= 1) {
        _subButton.enabled = NO;
    }else{
        _subButton.enabled = YES;
    }
    _numberFD = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_subButton.frame), 0, 40, _subButton.frame.size.height)];
    
    
    _subButton.backgroundColor=[UIColor clearColor];
    _numberFD.textAlignment=NSTextAlignmentCenter;
    _numberFD.keyboardType=UIKeyboardTypeNumberPad;
    _numberFD.clipsToBounds = YES;
    _numberFD.layer.borderColor = [[UIColor colorWithHexString:@"dddddd"] CGColor];
    _numberFD.layer.borderWidth = 0.5;
    _numberFD.textColor = [UIColor colorWithHexString:@"333333"];
    
    _numberFD.font=[UIFont systemFontOfSize:13];
    _numberFD.backgroundColor = [UIColor whiteColor];
    _numberFD.text=[NSString stringWithFormat:@"%zi",self.choosedCount];
    
    
    [self addSubview:_numberFD];
    
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];

 

    _addButton.frame = CGRectMake(CGRectGetMaxX(_numberFD.frame), 0, [UIImage imageWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"product_detail_sub_normal.png"]].size.width, [UIImage imageWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"product_detail_sub_normal.png"]].size.height);
    _addButton.backgroundColor=[UIColor clearColor];
    
    [_addButton setBackgroundImage:[UIImage imageWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"product_detail_add_normal.png"]] forState:UIControlStateNormal];
    [_addButton setBackgroundImage:[UIImage imageWithContentsOfFile:[bundlePath stringByAppendingPathComponent:@"product_detail_add_no.png"]] forState:UIControlStateDisabled];
    
    _addButton.exclusiveTouch = YES;
    [self addSubview:_addButton];
    if (self.choosedCount >= self.totalCount) {
        _addButton.enabled = NO;
    }else{
        _addButton.enabled = YES;
    }
}

@end
