//
//  UIFont+SVCCFont.h
//  SVCCommunePE
//
//  Created by leesunny on 2018/4/18.
//  Copyright © 2018年 leesunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,SVCCFontType){
    SVCCFontTypeNomal,
    SVCCFontTypeLight,
    SVCCFontTypeUltralight,
    SVCCFontTypeMedium,
    SVCCFontTypeRegular
};

@interface UIFont (SVCCFont)
+ (nullable UIFont *)fontSizeWithType:(SVCCFontType)fontType size:(CGFloat)fontSize;
@end
