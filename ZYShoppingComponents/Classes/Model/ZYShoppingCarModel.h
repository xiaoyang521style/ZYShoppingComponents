//
//  ZYShoppingCarModel.h
//  ShoppingComponents_Example
//
//  Created by Apple on 2020/11/2.
//  Copyright © 2020 xiaoyang521style. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYCommodityModel.h"
#import "ZYShoppingCarViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@class ZYShoppingCarModel;

@interface ZYShoppingCarModel : NSObject

@property(nonatomic,copy)NSString *item_id;
@property(nonatomic,copy)NSString *count;
@property(nonatomic,copy)NSString *item_size;
@property(nonatomic,strong)ZYCommodityModel *item_info;
@property(nonatomic,assign)BOOL isSelect;



@property(nonatomic,assign)NSInteger type;

@property(nonatomic,weak)ZYShoppingCarViewModel *vm;
@end

NS_ASSUME_NONNULL_END
