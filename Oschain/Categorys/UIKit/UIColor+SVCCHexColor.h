//
//  UIColor+SVCCHexColor.h
//  SVCCommunePE
//
//  Created by leesunny on 2018/4/10.
//  Copyright © 2018年 leesunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SVCCHexColor)

+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*)colorWithHex:(NSInteger)hexValue;
+ (UIColor*)whiteColorWithAlpha:(CGFloat)alphaValue;
+ (UIColor*)blackColorWithAlpha:(CGFloat)alphaValue;
+ (UIColor*)colorWithHexString:(NSString *)hexString;

@end
