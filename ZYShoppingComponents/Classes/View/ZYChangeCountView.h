//
//  ZYChangeCountView.h
//  ShoppingComponents_Example
//
//  Created by Apple on 2020/11/2.
//  Copyright © 2020 xiaoyang521style. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYChangeCountView : UIView
//加
@property (nonatomic, strong) UIButton *addButton;
//减
@property (nonatomic, strong) UIButton *subButton;
//数字按钮
@property (nonatomic, strong) UITextField  *numberFD;

//已选数
@property (nonatomic, assign) NSInteger choosedCount;


//总数
@property (nonatomic, assign) NSInteger totalCount;

- (instancetype)initWithFrame:(CGRect)frame chooseCount:(NSInteger)chooseCount totalCount:(NSInteger)totalCount;

@end

NS_ASSUME_NONNULL_END
