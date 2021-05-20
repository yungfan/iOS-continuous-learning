//
//  ViewController.m
//  自定义UIApplication
//
//  Created by student on 2018/4/2.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)logIn:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    btn.center = self.view.center;
    
    [btn addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

//1. 纯代码方式创建的事件
- (void)logOut:(UIButton *)sender {
    
    
}

//2.拽线方式创建的事件
- (IBAction)logIn:(id)sender {
    
    
}
@end
