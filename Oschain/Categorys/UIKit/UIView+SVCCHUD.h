//
//  UIView+SVCCHUD.h
//  SVCCommunePE
//
//  Created by leesunny on 2018/4/10.
//  Copyright © 2018年 leesunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SVCCHUD)
- (void)showHudTipStr:(NSString *)tipStr;
- (instancetype)showHUDQueryStr:(NSString *)titleStr;
- (void)drawDashLineWithLength:(int)lineLength
                   lineSpacing:(int)lineSpacing
                     lineColor:(UIColor *)lineColor;
@end
