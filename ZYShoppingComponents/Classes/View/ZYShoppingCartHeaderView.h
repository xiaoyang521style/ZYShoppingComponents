//
//  ZYShoppingCartHeardView.h
//  ShoppingComponents_Example
//
//  Created by Apple on 2020/11/2.
//  Copyright © 2020 xiaoyang521style. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^clickBlock)(UIButton *);

@interface ZYShoppingCartHeaderView : UIView
@property(nonatomic,copy)clickBlock blockBT;

- (instancetype)initWithFrame:(CGRect)frame section :(NSInteger )section carDataArrList:(NSMutableArray *)carDataArrList block:(void (^)(UIButton *))blockbt;
@end

NS_ASSUME_NONNULL_END
