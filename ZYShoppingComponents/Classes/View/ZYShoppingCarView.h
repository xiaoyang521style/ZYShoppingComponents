//
//  ZYShoppingCarView.h
//  ShoppingComponents_Example
//
//  Created by Apple on 2020/11/2.
//  Copyright © 2020 xiaoyang521style. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYShoppingCartEndView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZYShoppingCarView : UIView
-(instancetype)initWithController:(UIViewController *)controller frame:(CGRect)frame;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)ZYShoppingCartEndView *endView;

@property(nonatomic,strong)UIToolbar *toolbar;
@property (nonatomic , strong) UIBarButtonItem *previousBarButton;

@property(nonatomic,assign)BOOL isEdit;


/**
 绑定viewModel
 */
- (void)bindViewModel:(id)viewModel;

/**
 请求网络数据 绑定数据
 */
- (void)setupBinding;

/**
 设置数据回调，点击事件处理
 */
- (void)setupData;



@end

NS_ASSUME_NONNULL_END
