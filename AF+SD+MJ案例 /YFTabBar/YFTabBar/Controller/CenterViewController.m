//
//  CenterViewController.m
//  YFTabbarController
//
//  Created by student on 2018/3/12.
//  Copyright © 2018年 kangbing. All rights reserved.
//

#import "CenterViewController.h"
#import "UserModel.h"
#import "YFTabbarController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:@"plusX_Last"] forState:UIControlStateNormal];
    
    btn.bounds = CGRectMake(0, 0, 64, 64);
    
    btn.center = self.view.center;
    
    [self.view addSubview:btn];
        
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];

}


-(void)close{
    
  
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
