//
//  MainTabBarController.m
//  SSBaseProject
//
//  Created by 王少帅 on 2018/1/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"

@interface MainTabBarController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate, UITabBarControllerDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupAllChildViewControllers];
}


- (void)setupAllChildViewControllers
{
//    [self setupChildViewController:vc Title:@"tab1" ImageName:@"tabbar-1" SelectedImageName:@"tabbar-1-color"];
//    [self setupChildViewController:[[TabTwoVC alloc] init] Title:@"tab2" ImageName:@"tabbar-2" SelectedImageName:@"tabbar-2-color"];
//    [self setupChildViewController:[[TabThreeVC alloc] init] Title:@"tab3" ImageName:@"tabbar-3" SelectedImageName:@"tabbar-3-color"];
}


/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc Title:(NSString *)title ImageName:(NSString *)imageName SelectedImageName:(NSString *)selectedImageName
{
    childVc.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //常规字体颜色
    [childVc.tabBarItem setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    //选中字体颜色
    [childVc.tabBarItem setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
    
    
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:childVc];
    nav.navigationBar.tintColor = [UIColor blueColor];
    nav.navigationBar.barTintColor = [UIColor redColor];
    [nav.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithWhite:0 alpha:0.7], NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    [self addChildViewController:nav];
    nav.interactivePopGestureRecognizer.enabled = YES;
    nav.interactivePopGestureRecognizer.delegate = self;
}


#pragma mark - 系统侧滑手势返回
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    UINavigationController *nav = self.childViewControllers[self.selectedIndex];
    if (nav.childViewControllers.count == 1)
    {
        return NO;
    }
    return YES;
}


#if 0

#pragma mark - tab动画
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self animationWithIndex:[tabBar.items indexOfObject:item]];
}

#pragma mark - TabBar Item选中时图片的动画
- (void)animationWithIndex:(NSInteger)index
{
    //        NSMutableArray * tabBarButtonArray = [NSMutableArray array]; // 文字
    NSMutableArray * tabBarImageArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews)
    {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            //                        [tabBarButtonArray addObject:tabBarButton];  // 文字
            for (UIView *subV in tabBarButton.subviews)
            {
                if ([subV isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")])
                {
                    [tabBarImageArray addObject:subV];
                }
            }
        }
    }
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.25;
    animation.repeatCount = 0;
    animation.autoreverses = NO;
    animation.fromValue = @0.7;
    animation.toValue = @1;
    [[tabBarImageArray[index] layer]addAnimation:animation forKey:nil];
    //        [[tabBarButtonArray[index] layer]addAnimation:animation forKey:nil];  // 文字
}

#endif


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
