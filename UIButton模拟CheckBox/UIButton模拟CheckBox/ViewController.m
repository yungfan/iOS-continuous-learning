//
//  ViewController.m
//  UIButton模拟CheckBox
//
//  Created by 杨帆 on 2019/8/18.
//  Copyright © 2019 杨帆. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (IBAction)check:(id)sender {
    
    UIButton *btn  = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn.selected) { // 记住密码的操作
        
        NSLog(@"remember");
        
    }else{ // 不记住密码的操作
        
        NSLog(@"not remember");

    }
    
}

@end
