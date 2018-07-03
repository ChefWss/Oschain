//
//  UIFont+SVCCFont.m
//  SVCCommunePE
//
//  Created by leesunny on 2018/4/18.
//  Copyright © 2018年 leesunny. All rights reserved.
//

#import "UIFont+SVCCFont.h"

@implementation UIFont (SVCCFont)

+ (nullable UIFont *)fontSizeWithType:(SVCCFontType)fontType size:(CGFloat)fontSize {
    UIFont *font;
    switch (fontType) {
        case SVCCFontTypeLight:
            font = [UIFont fontWithName:@"PingFangSC-Light" size:fontSize];
            break;
        case SVCCFontTypeUltralight:
            font = [UIFont fontWithName:@"PingFangSC-Ultralight" size:fontSize];
            break;
        case SVCCFontTypeRegular:
            font = [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
            break;
        case SVCCFontTypeMedium:
            font = [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
            break;
        default:
            font = [UIFont fontWithName:@"PingFangSC" size:fontSize];
            break;
    }
    
    return font;
}

@end
