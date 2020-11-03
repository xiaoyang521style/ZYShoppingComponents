//
//  UIColor+ZYHex.h
//  ZYUnderlyingComponents
//
//  Created by Apple on 2020/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ZYHex)
/** 默认alpha为1 */
+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

/** 从十六进制字符串获取颜色,默认alpha为1 */
+ (UIColor *)colorWithHexString:(NSString *)color;

/** 从十六进制字符串获取颜色，alpha需要自己传递 color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
