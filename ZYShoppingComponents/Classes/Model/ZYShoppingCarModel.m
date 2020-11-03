//
//  ZYShoppingCarModel.m
//  ShoppingComponents_Example
//
//  Created by Apple on 2020/11/2.
//  Copyright © 2020 xiaoyang521style. All rights reserved.
//

#import "ZYShoppingCarModel.h"

@implementation ZYShoppingCarModel

- (void)setVm:(ZYShoppingCarViewModel *)vm
{
    _vm = vm;
    [self addObserver:vm forKeyPath:@"isSelect" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}
-(void)dealloc
{

    if (_vm) {
     [self removeObserver:_vm forKeyPath:@"isSelect"];

    }
    
    
}


@end
