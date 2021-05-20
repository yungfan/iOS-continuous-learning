//
//  ViewController.m
//  测试
//
//  Created by teacher on 17/6/15.
//  Copyright © 2017年 安徽商贸职业技术学院. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    //1、Xib只有设置Size为Freeform才可以调整大小
    NSArray<UIView *> *views = [[NSBundle mainBundle] loadNibNamed:@"BlueView" owner:nil options:nil];
    
    //2、加载出来的只有一个View不包含子View
    UIView *view = [views lastObject];
    
    //3、Xib中设置的尺寸多大这里就多大
    NSLog(@"%@", NSStringFromCGRect(view.frame));
    
    //4、一般会根据需要，将Xib加载的View显示为多大的尺寸需要自己设置 这里不用考虑最外层的那个父View 只需要考虑里面子View的自动布局即可
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, view.frame.size.height);
    
    NSLog(@"%@", NSStringFromCGRect(view.frame));
    
    //5、加载->设置显示尺寸（有必要）->添加显示
    [self.view addSubview:view];
}


@end
