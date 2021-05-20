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
#import "LoginViewController.h"
#import "YFTabbar.h"

@interface YFTabbarController ()<UITabBarControllerDelegate, passValue>

@property(nonatomic) UIViewController * selectedVC;

@property(nonatomic) BOOL isLogin;

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

    self.delegate = self;

    
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

//这个tabBarController的代理方法，在返回值是NO的时候，代表还没有跳转到点击的这个控制器，可以在这之前做一些操作如登录界面
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    
    //NSLog(@"%ld == %@ == %@",tabBarController.selectedIndex,tabBarController,viewController);
    
    self.selectedVC = viewController;
    
    if ([viewController.tabBarItem.title isEqualToString:@"设置"] && self.isLogin == NO){
    
        self.isLogin = YES;

        LoginViewController *loginViewController = [[LoginViewController alloc]init];
        
        loginViewController.delegate = self;
        
        YFNavigationController *loginNavViewController = [[YFNavigationController alloc]initWithRootViewController:loginViewController];
        
        [self presentViewController:loginNavViewController animated:YES completion:nil];
        
       
        return NO;
    }
    
    
    // 确保当前显示的是第一个tabBar
    if ([tabBarController.selectedViewController isEqual:[tabBarController.viewControllers firstObject]]) {
        // 再次选中的是当前的控制器
        if ([viewController isEqual:tabBarController.selectedViewController]) {
            // 执行操作
            NSLog(@"刷新界面");
            
            return NO;
        }
        
    }
    
    return YES;

}

-(void)setSelectedVC{
    
    //LoginViewController界面点击登录按钮后回调该方法
    self.selectedViewController = self.selectedVC;

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
