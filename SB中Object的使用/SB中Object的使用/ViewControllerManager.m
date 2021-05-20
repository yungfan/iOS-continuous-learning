//
//  ViewControllerManager.m
//  SB中Object的使用
//
//  Created by student on 2018/4/2.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewControllerManager.h"

@implementation ViewControllerManager

//VC中的按钮事件转移到Object中
- (IBAction)click:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    [btn setTitle:self.title forState:UIControlStateNormal];
    
    NSLog(@"%s", __func__);
}

@end
