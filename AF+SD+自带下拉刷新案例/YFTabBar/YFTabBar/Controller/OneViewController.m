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
    
        
    self.view.backgroundColor = [UIColor greenColor];
        
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
    [btn setImage:[UIImage imageNamed:@"plusX_Last"] forState:UIControlStateNormal];
        
    btn.bounds = CGRectMake(0, 0, 64, 64);
        
    btn.center = self.view.center;
        
    [self.view addSubview:btn];
        
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
}




-(void)close{
    
    TwoViewController *tvc = [[TwoViewController alloc]init];
    
    [self.navigationController pushViewController:tvc animated:YES];
    
}


@end
