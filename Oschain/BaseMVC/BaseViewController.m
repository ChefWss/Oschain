//
//  BaseViewController.m
//  SSBaseProject
//
//  Created by 王少帅 on 2018/1/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - 获取当前控制器
+ (UIViewController *)currentViewController
{
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [BaseViewController findBestViewController:viewController];
}


//循环查找
+ (UIViewController *) findBestViewController:(UIViewController *)vc
{
    if (vc.presentedViewController)
    {
        // Return presented view controller
        return [BaseViewController findBestViewController:vc.presentedViewController];
    }
    else if ([vc isKindOfClass:[UINavigationController class]])
    {
        // Return top view
        UINavigationController *svc = (UINavigationController *)vc;
        if (svc.viewControllers.count > 0) return [BaseViewController findBestViewController:svc.topViewController];
        else                               return vc;
    }
    else if ([vc isKindOfClass:[UITabBarController class]])
    {
        // Return visible view
        UITabBarController *svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0) return [BaseViewController findBestViewController:svc.selectedViewController];
        else                              return vc;
    }
    else
    {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
