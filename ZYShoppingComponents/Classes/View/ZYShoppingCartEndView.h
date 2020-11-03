//
//  ZYShoppingCartEndView.h
//  ShoppingComponents_Example
//
//  Created by Apple on 2020/11/2.
//  Copyright © 2020 xiaoyang521style. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ZYShoppingCartEndViewDelegate;

@interface ZYShoppingCartEndView : UIView
@property(nonatomic,assign)BOOL isEdit;
@property(weak,nonatomic)id<ZYShoppingCartEndViewDelegate> delegate;
@property(nonatomic,strong)UILabel *Lab;

+(CGFloat)getViewHeight;
@end

@protocol ZYShoppingCartEndViewDelegate <NSObject>

-(void)clickALLEnd:(UIButton *)bt;

-(void)clickRightBT:(UIButton *)bt;
@end

NS_ASSUME_NONNULL_END
