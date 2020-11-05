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
#import "ZYShoppingCarCell.h"
#import <ReactiveObjC/ReactiveObjC.h>
@implementation ZYShoppingCarViewModel

#pragma mark 懒加载

- (NSMutableArray *)carDataArrList
{
    if (!_carDataArrList) {
        _carDataArrList = [NSMutableArray array];
    }
    return _carDataArrList;
}

#pragma mark 数据请求处理
- (void)getShopData:(void (^)(NSArray * commonArry, NSArray * kuajingArry))shopDataBlock {
    
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
        model.type=1;
        model.isSelect=YES;
        [commonMuList addObject:model];
        [self observeModel:model];
    }
    for (int i = 0; i<kuajingList.count; i++) {
        ZYShoppingCarModel *model = [ZYShoppingCarModel mj_objectWithKeyValues:[kuajingList objectAtIndex:i]];
        model.type=2;
        model.isSelect=YES;
        [kuajingMuList addObject:model];
        [self observeModel:model];
    }
    if (commonMuList.count>0) {
        
        [commonMuList addObject:[self verificationSelect:commonMuList type:@"1"]];
        
    }
    if (kuajingMuList.count>0) {
        
        [kuajingMuList addObject:[self verificationSelect:kuajingMuList type:@"2"]];
    }
    [self.carDataArrList addObject:commonMuList];
    [self.carDataArrList addObject:kuajingMuList];
    self.isNeedRefresh = YES;
    [self numPrice];
    
    shopDataBlock(commonMuList,kuajingMuList);
}
-(void)observeModel:(ZYShoppingCarModel *)model {
    @weakify(self);
    [[RACObserve(model, isSelect) ignore:nil] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self numPrice];
        NSLog(@"%@",x);
    }];
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


- (void)pitchOn
{
    for (int i =0; i<self.carDataArrList.count; i++) {
        NSArray *dataList = [self.carDataArrList objectAtIndex:i];
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
        [weakself.carDataArrList addObject:commonArry];
        [weakself.carDataArrList addObject:kuajingArry];
        weakself.isNeedRefresh = YES;
        [weakself numPrice];
    }];
}
#pragma 计算价格
- (void)numPrice
{
    float num = 0.00;
    for (int i=0; i<self.carDataArrList.count; i++) {
        NSArray *list = [self.carDataArrList objectAtIndex:i];
        for (int j = 0; j<list.count-1; j++) {
            ZYShoppingCarModel *model = [list objectAtIndex:j];
            NSInteger count = [model.count integerValue];
            float sale = [model.item_info.sale_price floatValue];
            if (model.isSelect && ![model.item_info.sale_state isEqualToString:@"3"] ) {
                num = count*sale+ num;
            }
        }
    }
    self.price = [NSString stringWithFormat:@"￥%.2f",num];
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
-(void)edits:(BOOL)edit {
    if (edit) {
        for (int i=0; i<self.carDataArrList.count; i++) {
            NSArray *list = [self.carDataArrList objectAtIndex:i];
            for (int j = 0; j<list.count-1; j++) {
                ZYShoppingCarModel *model = [list objectAtIndex:j];
                if ([model.item_info.sale_state isEqualToString:@"3"]) {
                    model.isSelect=NO;
                }
                else
                {
                    model.isSelect=YES;
                }
                
            }
        }
    }
    else{
     
        for (int i=0; i<self.carDataArrList.count; i++) {
            NSArray *list = [self.carDataArrList objectAtIndex:i];
            for (int j = 0; j<list.count-1; j++) {
                ZYShoppingCarModel *model = [list objectAtIndex:j];
                model.isSelect = YES;
            }
        }
    }
}
#pragma mark 全选
-(void)seletAll:(NSString*)checked select:(BOOL) selected edit:(BOOL)edit{
    if (edit) {
        //取消
        for (int i =0; i<self.carDataArrList.count; i++) {
            NSArray *dataList = [self.carDataArrList objectAtIndex:i];
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
        for (int i =0; i<self.carDataArrList.count; i++) {
            NSArray *dataList = [self.carDataArrList objectAtIndex:i];
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
-(void)delectSelet {
    for (int i = 0; i<self.carDataArrList.count; i++) {
        NSMutableArray *arry = [self.carDataArrList objectAtIndex:i];
        for (int j=0 ; j<arry.count-1; j++) {
            ZYShoppingCarModel *model = [ arry objectAtIndex:j];
            if (model.isSelect==YES) {
                [arry removeObjectAtIndex:j];
                continue;
            }
        }
        if (arry.count<=1) {
            [self.carDataArrList removeObjectAtIndex:i];
        }
    }
}
#pragma mark 结算
-(void)settlement{
    
}

-(void)dealloc {
    NSLog(@"ZYShoppingCarViewModel 释放了");
}



- (NSInteger)numberOfSections {
    return self.carDataArrList.count;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    NSArray *list = [self.carDataArrList objectAtIndex:section];
    return list.count-1;
}


- (CGFloat)heightForHeaderInSection:(NSInteger)section{
        if (section==0) {
            return 50;
        }
        else
        {
            return 40;
        }
}

- (CGFloat)heightForFooterInSection:(NSInteger)section{
      return 10;
}

-(CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ZYShoppingCarCell getHeight];
}

@end
