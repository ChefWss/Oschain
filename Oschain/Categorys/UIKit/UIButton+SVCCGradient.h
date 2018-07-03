//
//  UIButton+SVCCGradient.h
//  SVCCommunePE
//
//  Created by leesunny on 2018/4/16.
//  Copyright © 2018年 leesunny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+SVCCGradient.h"

@interface UIButton (SVCCGradient)
/**
 *  根据给定的颜色，设置按钮的颜色
 *  @param btnSize  这里要求手动设置下生成图片的大小，防止coder使用第三方layout,没有设置大小
 *  @param clrs     渐变颜色的数组
 *  @param percent  渐变颜色的占比数组
 *  @param type     渐变色的类型
 */
- (UIButton *)gradientButtonWithSize:(CGSize)btnSize colorArray:(NSArray *)clrs percentageArray:(NSArray *)percent gradientType:(GradientType)type;
- (UIButton *)gradientButton;

/********************************************************************************/

/**
 *  扩大 UIButton 的點擊範圍
 *  控制上下左右的延長範圍
 *
 *  @parm top
 *  @parm right
 *  @parm bottom
 *  @parm left
 */
- (void)setEnlargeEdge:(CGFloat)size;
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left; 


@end
