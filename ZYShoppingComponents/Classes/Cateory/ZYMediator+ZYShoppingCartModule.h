//
//  ZYMediator+ZYShoppingCartModule.h
//  ZYShoppingComponents
//
//  Created by Apple on 2020/11/3.
//

#import <ZYMediator/ZYMediator.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYMediator (ZYShoppingCartModule)
- (UIViewController *)ShoppingCartModule_viewControllerWithParam:(NSDictionary *)pararm callback:(void(^)(id result))callback;
@end

NS_ASSUME_NONNULL_END
