//
//  ZYMediator+HandyTools.h
//  ZYMediator
//
//  Created by Apple on 2020/10/29.
//
#if TARGET_OS_IOS
#import "ZYMediator.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYMediator (HandyTools)
- (UIViewController * _Nullable)topViewController;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ _Nullable )(void))completion;

@end

NS_ASSUME_NONNULL_END


#endif
