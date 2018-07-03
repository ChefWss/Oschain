//
//  UIImageView+SVCCExtend.m
//  SVCCommunePE
//
//  Created by leesunny on 2018/4/14.
//  Copyright © 2018年 leesunny. All rights reserved.
//

#import "UIImage+SVCCExtend.h"

@implementation UIImage (SVCCExtend)

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)imageFromColor:(UIColor *)color {
    return [UIImage createImageWithColor:color size:CGSizeMake(1, 1)];
}
@end
