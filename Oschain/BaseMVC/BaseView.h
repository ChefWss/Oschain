//
//  BaseView.h
//  SSBaseProject
//
//  Created by 王少帅 on 2018/1/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

//删除所有子视图
+ (void)removeAllSubViewsFormView:(UIView *)view;
//删除指定tag子试图
+ (void)removeSubviewWithTag:(NSInteger)tag fromView:(UIView *)view;

@end
