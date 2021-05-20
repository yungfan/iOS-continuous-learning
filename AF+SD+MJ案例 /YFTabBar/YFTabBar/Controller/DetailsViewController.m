//
//  DetailsViewController.m
//  YFTabBar
//
//  Created by student on 2018/3/26.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"详情";
    
    UIWebView *details = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [details loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    [self.view addSubview:details];
}
@end
