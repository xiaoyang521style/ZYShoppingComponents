//
//  ZYMediator+ZYShoppingCartModule.m
//  ZYShoppingComponents
//
//  Created by Apple on 2020/11/3.
//

#import "ZYMediator+ZYShoppingCartModule.h"

@implementation ZYMediator (ZYShoppingCartModule)
- (UIViewController *)ShoppingCartModule_viewControllerWithParam:(NSDictionary *)pararm callback:(void(^)(id result))callback {
    NSMutableDictionary *url_params = [[NSMutableDictionary alloc] init];
    url_params[@"callback"] = callback;
    url_params[@"params"] = pararm;
    return [self performTarget:@"ZYShoppingCartMoudel" action:@"viewController" params:url_params shouldCacheTarget:NO];
}

@end
