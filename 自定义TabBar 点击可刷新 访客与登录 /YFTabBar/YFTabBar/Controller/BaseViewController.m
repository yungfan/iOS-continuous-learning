//
//  BaseViewController.m
//  YFTabbarController
//
//  Created by yangfan on 2018/3/20.
//  Copyright © 2018年 kangbing. All rights reserved.
//

#import "BaseViewController.h"
#import "UserModel.h"
#import "UserModel.h"

@interface BaseViewController ()


@end

@implementation BaseViewController


-(void)loadView{
    
    self.isLogin = [UserModel shareInstance].isLogin;
    
    //根据isLogin判断用户是否登录 如果未登录就显示访客视图 否则就显示正常界面
    //但是注意 子视图同样需要在viewDidLoad中判断用户是否登录
    //在登录界面 应该重新赋值window的rootViewController 刷新控制器的状态
    self.isLogin ? [super loadView] : [self setupVisitorView];
    
}

-(void)setupVisitorView{
    
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    view.backgroundColor = [UIColor cyanColor];
    
    self.view = view;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
