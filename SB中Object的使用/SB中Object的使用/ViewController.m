//
//  ViewController.m
//  SB中Object的使用
//
//  Created by student on 2018/4/2.
//  Copyright © 2018年 student. All rights reserved.


//1. SB中添加一个Object到VC上
//2. 设置Object的Class为ViewControllerManager
//3. 拽线到VC，使之成为VC的一个属性
//4. 在ViewControllerManager中定义IBOutlet和IBAction
//5. 在SB中右击Object，将4种定义的事件与VC中的UI控件相连

#import "ViewController.h"
#import "ViewControllerManager.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet ViewControllerManager *obj;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       
    self.obj.title = @"VC将Click事件拿到Object中了，并完成传值";
}

@end
