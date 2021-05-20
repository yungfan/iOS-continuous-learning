//
//  YFTabbarController.m
//  YFTabbarController
//
//  Created by kangbing on 16/5/31.
//  Copyright © 2016年 kangbing. All rights reserved.
//

#import "YFTabbarController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "CenterViewController.h"
#import "YFNavigationController.h"
#import "YFTabbar.h"

@interface YFTabbarController ()

@end

@implementation YFTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    OneViewController *hvc = [[OneViewController alloc] init];
    [self addChildController:hvc title:@"首页" imageName:@"tab1-heartshow" selectedImageName:@"tab1-heart"];
    
    TwoViewController *fvc = [[TwoViewController alloc] init];
    [self addChildController:fvc title:@"活动" imageName:@"tab2-doctor" selectedImageName:@"tab2-doctorshow"];
    
    ThreeViewController *MoreVc = [[ThreeViewController alloc] init];
    [self addChildController:MoreVc title:@"更多" imageName:@"tab4-more" selectedImageName:@"tab4-moreshow"];
    
    FourViewController *svc = [[FourViewController alloc] init];
    [self addChildController:svc title:@"设置" imageName:@"tab5-file" selectedImageName:@"tab5-fileshow"];
    
    
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1.0]]];
    // 设置tabbar
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    // 设置自定义的tabbar
    [self setCustomtabbar];
    
    
    
}

- (void)setCustomtabbar{

    YFTabbar *tabbar = [[YFTabbar alloc]init];
    
    tabbar.vcCount = (int)self.viewControllers.count;
    
    [self setValue:tabbar forKeyPath:@"tabBar"];

    [tabbar.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];


}

- (void)centerBtnClick:(UIButton *)button{
    
    CenterViewController *centerViewController = [[CenterViewController alloc]init];
    
    YFNavigationController *centerNavViewController = [[YFNavigationController alloc]initWithRootViewController:centerViewController];

    [self presentViewController:centerNavViewController animated:YES completion:nil];
    
}




- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName
{
    
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置一下选中tabbar文字颜色
    [childController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor darkGrayColor] } forState:UIControlStateSelected];
    
    YFNavigationController * nav = [[YFNavigationController alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
}


- (UIImage *)imageWithColor:(UIColor *)color{
    // 一个像素
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
