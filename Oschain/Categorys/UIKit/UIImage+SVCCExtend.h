//
//  UIImageView+SVCCExtend.h
//  SVCCommunePE
//
//  Created by leesunny on 2018/4/14.
//  Copyright © 2018年 leesunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SVCCExtend)

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageFromColor:(UIColor *)color;

@end
