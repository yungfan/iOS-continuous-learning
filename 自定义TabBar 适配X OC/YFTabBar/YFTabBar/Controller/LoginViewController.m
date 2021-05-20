//
//  LoginViewController.m
//  YFTabBar
//
//  Created by student on 2018/4/27.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "LoginViewController.h"
#import "FourViewController.h"

@interface LoginViewController ()<UITabBarControllerDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:@"plusX_Last"] forState:UIControlStateNormal];
    
    btn.bounds = CGRectMake(0, 0, 64, 64);
    
    btn.center = self.view.center;
    
    [self.view addSubview:btn];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)close{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //登录成功后，来跳转到你点击的控制器
    if(self.delegate && [self.delegate respondsToSelector:@selector(setSelectedVC)]){
        [self.delegate setSelectedVC];
    }

}

@end
