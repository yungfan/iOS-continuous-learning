//
//  ViewController.m
//  ExtraView的使用
//
//  Created by student on 2018/4/2.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


//1. 添加一个UIView为VC的ExtraView
//2. 拽线到VC
//3. 设置尺寸和布局
//4. 添加到VC的View上去
//5. 适当的时机移除掉
@property (strong, nonatomic) IBOutlet UIView *extraView;
- (IBAction)retry:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.extraView.frame = self.view.frame;
    
    [self.view addSubview:self.extraView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)retry:(id)sender {
    
    [self.extraView removeFromSuperview];
}
@end
