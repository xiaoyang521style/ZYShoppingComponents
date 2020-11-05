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
@interface ZYShoppingCarViewModel : NSObject
@property(nonatomic,strong)NSMutableArray *carDataArrList;
@property(nonatomic,assign)NSString *price;
@property(nonatomic,assign)BOOL isNeedRefresh;
#pragma mark 数据请求处理
- (void)getShopData:(void (^)(NSArray * commonArry, NSArray * kuajingArry))shopDataBlock;

-(void)initData;
-(void)edits:(BOOL)edit;
-(void)clickAllBT:(NSMutableArray *)carDataArrList bt:(UIButton *)bt;
- (void)pitchOn;
//全选
-(void)seletAll:(NSString*)checked select:(BOOL) selected edit:(BOOL)edit;
//删除
-(void)delectSelet;
//结算
-(void)settlement;


- (NSInteger)numberOfSections;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;


- (CGFloat)heightForHeaderInSection:(NSInteger)section;

- (CGFloat)heightForFooterInSection:(NSInteger)section;

-(CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;



@end

NS_ASSUME_NONNULL_END
