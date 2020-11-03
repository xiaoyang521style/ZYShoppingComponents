//
//  ZYShoppingCarViewModel.m
//  ShoppingComponents_Example
//
//  Created by Apple on 2020/11/2.
//  Copyright © 2020 xiaoyang521style. All rights reserved.
//

#import "ZYShoppingCarViewModel.h"
#import "ZYShoppingCarModel.h"
#import "ZYShoppingCarView.h"
#import "MJExtension.h"
@implementation ZYShoppingCarViewModel


- (void)getNumPrices:(void (^)()) priceBlock
{
    _priceBlock = priceBlock;
}

#pragma mark 数据请求处理
- (void)getShopData:(void (^)(NSArray * commonArry, NSArray * kuajingArry))shopDataBlock  priceBlock:(void (^)()) priceBlock
{
    //访问网络 获取数据 block回调失败或者成功 都可以在这处理
    
    //本demo 直接读 本地数据了
  
    NSString  *bundlePath = [[NSBundle mainBundle] pathForResource:@"Frameworks/ZYShoppingComponents.framework/ZYShoppingComponents" ofType:@"bundle"];
 
    NSString *plistPath = [bundlePath stringByAppendingPathComponent:@"data.plist"];
    NSMutableDictionary *strategyDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    if (strategyDic == nil) {
        return;
    }
    
    NSArray *commonList = [strategyDic objectForKey:@"common"];
    
    NSArray *kuajingList = [strategyDic objectForKey:@"kuajing"];
    
    NSMutableArray *commonMuList = [NSMutableArray array];
    
    NSMutableArray *kuajingMuList = [NSMutableArray array];
    
    
    for (int i = 0; i<commonList.count; i++) {
        ZYShoppingCarModel *model = [ZYShoppingCarModel mj_objectWithKeyValues:[commonList objectAtIndex:i]];
        model.vm =self;
        model.type=1;
        model.isSelect=YES;
        [commonMuList addObject:model];
        
    }
    for (int i = 0; i<kuajingList.count; i++) {
        ZYShoppingCarModel *model = [ZYShoppingCarModel mj_objectWithKeyValues:[kuajingList objectAtIndex:i]];
        model.vm =self;
        model.type=2;
        model.isSelect=YES;
        [kuajingMuList addObject:model];
    }
    if (commonMuList.count>0) {
        
        [commonMuList addObject:[self verificationSelect:commonMuList type:@"1"]];
        
    }
    if (kuajingMuList.count>0) {
        
        [kuajingMuList addObject:[self verificationSelect:kuajingMuList type:@"2"]];
    }
    _priceBlock = priceBlock;
    shopDataBlock(commonMuList,kuajingMuList);
}

- (NSDictionary *)verificationSelect:(NSMutableArray *)arr type:(NSString *)type
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"YES" forKey:@"checked"];
    [dic setObject:type forKey:@"type"];
    for (int i =0; i<arr.count; i++) {
        ZYShoppingCarModel *model = (ZYShoppingCarModel *)[arr objectAtIndex:i];
        if (!model.isSelect) {
            [dic setObject:@"NO" forKey:@"checked"];
            break;
        }
    }
    
    return dic;
}


- (void)pitchOn:(NSMutableArray *)carDataArrList
{
    for (int i =0; i<carDataArrList.count; i++) {
        NSArray *dataList = [carDataArrList objectAtIndex:i];
        NSMutableDictionary *dic = [dataList lastObject];
         [dic setObject:@"YES" forKey:@"checked"];
        for (int j=0; j<dataList.count-1; j++) {
            ZYShoppingCarModel *model = (ZYShoppingCarModel *)[dataList objectAtIndex:j];
            if (model.type==1 ) {
                if (!model.isSelect && ![model.item_info.sale_state isEqualToString:@"3"]) {
                    [dic setObject:@"NO" forKey:@"checked"];
                    break;
                }
                
            }
            else if(model.type==2 )
            {
            
                if (!model.isSelect &&![model.item_info.sale_state isEqualToString:@"3"]) {
                    [dic setObject:@"NO" forKey:@"checked"];
                    break;
                }
            }
        }
    }
}
-(void)initData{
    __weak typeof(self) weakself = self;
    [self getShopData:^(NSArray * _Nonnull commonArry, NSArray * _Nonnull kuajingArry) {
        [weakself.shoppingCarView.carDataArrList addObject:commonArry];
        [weakself.shoppingCarView.carDataArrList addObject:kuajingArry];
        [weakself.shoppingCarView.tableView reloadData];
        [weakself numPrice];
        } priceBlock:^{
            [weakself numPrice];
    }];
}
#pragma 计算价格
- (void)numPrice
{
    NSArray *lists =   [self.shoppingCarView.endView.Lab.text componentsSeparatedByString:@"￥"];
    float num = 0.00;
    for (int i=0; i<self.shoppingCarView.carDataArrList.count; i++) {
        NSArray *list = [self.shoppingCarView.carDataArrList objectAtIndex:i];
        for (int j = 0; j<list.count-1; j++) {
            ZYShoppingCarModel *model = [list objectAtIndex:j];
            NSInteger count = [model.count integerValue];
            float sale = [model.item_info.sale_price floatValue];
            if (model.isSelect && ![model.item_info.sale_state isEqualToString:@"3"] ) {
                num = count*sale+ num;
            }
        }
    }
    self.shoppingCarView.endView.Lab.text = [NSString stringWithFormat:@"%@￥%.2f",lists[0],num];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"开始计算价钱");
    if ([keyPath isEqualToString:@"isSelect"]) {
        if (_priceBlock!=nil) {
             _priceBlock();
        }
       
    }
}

-(void)clickAllBT:(NSMutableArray *)carDataArrList bt:(UIButton *)bt
{
    
    
    
    bt.selected = !bt.selected;
    
    for (int i =0; i<carDataArrList.count; i++) {
        NSArray *dataList = [carDataArrList objectAtIndex:i];
        NSMutableDictionary *dic = [dataList lastObject];
        for (int j=0; j<dataList.count-1; j++) {
            ZYShoppingCarModel *model = (ZYShoppingCarModel *)[dataList objectAtIndex:j];
            if (model.type==1 && bt.tag==100) {
                if (bt.selected) {
                    [dic setObject:@"YES" forKey:@"checked"];
                }
                else
                {
                    [dic setObject:@"NO" forKey:@"checked"];
                }
                if ([model.item_info.sale_state isEqualToString:@"3"]) {
                    continue;
                }
                else{
                    model.isSelect=bt.selected;
                }
                
            }
            else if(model.type==2 &&bt.tag==101)
            {
                if (bt.selected) {
                    [dic setObject:@"YES" forKey:@"checked"];
                }
                else
                {
                    [dic setObject:@"NO" forKey:@"checked"];
                }
                if ([model.item_info.sale_state isEqualToString:@"3"]) {
                    continue;
                }
                else{
                    model.isSelect=bt.selected;
                }
            }
        }
    }
}

#pragma mark 全选
-(void)seletAll:(NSString*)checked select:(BOOL) selected edit:(BOOL)edit carDataArrList:(NSMutableArray *)carDataArrList{
    if (edit) {
        //取消
        for (int i =0; i<self.shoppingCarView.carDataArrList.count; i++) {
            NSArray *dataList = [self.shoppingCarView.carDataArrList objectAtIndex:i];
            NSMutableDictionary *dic = [dataList lastObject];
            
            [dic setObject:checked forKey:@"checked"];
            for (int j=0; j<dataList.count-1; j++) {
                ZYShoppingCarModel *model = (ZYShoppingCarModel *)[dataList objectAtIndex:j];
                if (![model.item_info.sale_state isEqualToString:@"3"]) {
                    model.isSelect= selected;
                }
            }
        }
    }else{
        //编辑
        for (int i =0; i<self.shoppingCarView.carDataArrList.count; i++) {
            NSArray *dataList = [self.shoppingCarView.carDataArrList objectAtIndex:i];
            NSMutableDictionary *dic = [dataList lastObject];
            [dic setObject:checked forKey:@"checked"];
            for (int j=0; j<dataList.count-1; j++) {
                ZYShoppingCarModel *model = (ZYShoppingCarModel *)[dataList objectAtIndex:j];
                model.isSelect=selected;
            }
        }
    }
}
#pragma mark 删除
-(void)delectSelet:(NSMutableArray *)carDataArrList {
    for (int i = 0; i<carDataArrList.count; i++) {
        NSMutableArray *arry = [carDataArrList objectAtIndex:i];
        for (int j=0 ; j<arry.count-1; j++) {
            ZYShoppingCarModel *model = [ arry objectAtIndex:j];
            if (model.isSelect==YES) {
                [arry removeObjectAtIndex:j];
                continue;
            }
        }
        if (arry.count<=1) {
            [carDataArrList removeObjectAtIndex:i];
        }
    }
}
#pragma mark 结算
-(void)settlement{
    
}

-(void)dealloc {
    NSLog(@"ZYShoppingCarViewModel 释放了");
}
@end
