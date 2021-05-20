//
//  WWNavigationController.m
//  转屏控制
//
//  Created by mac on 14/12/2.
//  Copyright (c) 2014年 WangWei. All rights reserved.
//

#import "WWNavigationController.h"

@interface WWNavigationController ()

@end

@implementation WWNavigationController


//控制设备自旋转方向，只能控制由该导航控制器推出的视图，其他顶级视图（比如系统自动调用打开的视频窗口等）
-(BOOL)shouldAutorotate
{
    //这里必须为YES，否则私有API无法生效
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[[self.topViewController class] description] isEqualToString:@"nextViewController"]) {
        //B可以支持的自旋转方向，不支持的话，强制旋转也没用
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if ([[[self.topViewController class] description] isEqualToString:@"nextViewController"]) {
        //B的首选方向
        return UIInterfaceOrientationLandscapeLeft;
    }
    return UIInterfaceOrientationPortrait;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if ([[[viewController class] description] isEqualToString:@"nextViewController"]) {
        //B入栈，则强制横向
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
    }
    else {
        //B之后的，强制纵向
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController* popedViewController = [super popViewControllerAnimated:animated];
    if ([[[popedViewController class] description] isEqualToString:@"nextViewController"]) {
        //B出栈后，强制纵向
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
    }
    else {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
    }
    return popedViewController;
}

@end
