//
//  Target_ZYShoppingCartMoudel.m
//  ZYShoppingComponents
//
//  Created by Apple on 2020/11/3.
//

#import "Target_ZYShoppingCartMoudel.h"
#import "ZYShoppingCarViewController.h"
@implementation Target_ZYShoppingCartMoudel
- (UIViewController *)Action_viewController:(NSDictionary *)params {
    ZYShoppingCarViewController *vc = [[ZYShoppingCarViewController alloc]initWithParams:params];
    return vc;
}
@end
