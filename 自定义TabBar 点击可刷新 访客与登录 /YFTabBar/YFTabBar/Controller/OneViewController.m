//
//  OneViewController.m
//  YFTabbarController
//
//  Created by kangbing on 16/5/31.
//  Copyright © 2016年 kangbing. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //
    
    if (self.isLogin) {
        
        self.view.backgroundColor = [UIColor greenColor];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"plusX_Last"] forState:UIControlStateNormal];
        
        btn.bounds = CGRectMake(0, 0, 64, 64);
        
        btn.center = self.view.center;
        
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        //捕获“双击”通知 可以做刷新、回滚
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(doubleClickTab:) name:@"DoubleClickTabbarItemNotification" object:nil];
        
    }
    
   
    
}

-(void)doubleClickTab:(NSNotification *)notification{
    
    
    //这里有个坑 就是直接用NSInteger接收会有问题 数字不对
    //因为上个界面传过来的时候封装成了对象，所以用NSNumber接收后再取值
    NSNumber *index = notification.object;
    
    if ([index intValue] == 0) {
        
        //可以做刷新或者回滚操作
        NSLog(@"%s", __func__);
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)close{
    
    TwoViewController *tvc = [[TwoViewController alloc]init];
    
    [self.navigationController pushViewController:tvc animated:YES];
    
}

-(void)dealloc{
    
     [[NSNotificationCenter defaultCenter] removeObserver:self];

}


@end
