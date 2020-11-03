//
//  ZYShoppingCarViewModel.h
//  ShoppingComponents_Example
//
//  Created by Apple on 2020/11/2.
//  Copyright © 2020 xiaoyang521style. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ZYShoppingCarView;
typedef void(^NumPriceBlock)();
@interface ZYShoppingCarViewModel : NSObject

@property(nonatomic, weak)ZYShoppingCarView *shoppingCarView;
@property(nonatomic,copy)NumPriceBlock priceBlock;

#pragma mark 数据请求处理
- (void)getShopData:(void (^)(NSArray * commonArry, NSArray * kuajingArry))shopDataBlock  priceBlock:(void (^)()) priceBlock;

-(void)initData;

-(void)clickAllBT:(NSMutableArray *)carDataArrList bt:(UIButton *)bt;
- (void)pitchOn:(NSMutableArray *)carDataArrList;
//全选
-(void)seletAll:(NSString*)checked select:(BOOL) selected edit:(BOOL)edit carDataArrList:(NSMutableArray *)carDataArrList;
//删除
-(void)delectSelet:(NSMutableArray *)carDataArrList;
//结算
-(void)settlement;
@end

NS_ASSUME_NONNULL_END
