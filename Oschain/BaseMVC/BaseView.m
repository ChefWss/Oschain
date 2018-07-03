//
//  BaseView.m
//  SSBaseProject
//
//  Created by 王少帅 on 2018/1/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

//删除所有子视图
+ (void)removeAllSubViewsFormView:(UIView *)view
{
    for (UIView *v in view.subviews)
    {
        [v removeFromSuperview];
    }
}
//删除指定tag子试图
+ (void)removeSubviewWithTag:(NSInteger)tag fromView:(UIView *)view
{
    UIView *v = [view viewWithTag:tag];
    if (v)
    {
        [v removeFromSuperview];
    }
}

@end
