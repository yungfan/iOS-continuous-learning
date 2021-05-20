//
//  ViewController.m
//  iOS8之后的UINavigationViewController新特性
//
//  Created by 杨帆 on 2018/8/23.
//  Copyright © 2018年 杨帆. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
    [self.webView loadRequest:request];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

    //self.navigationController.hidesBarsWhenVerticallyCompact = YES;
    //self.navigationController.hidesBarsOnTap = YES;
    //self.navigationController.hidesBarsWhenKeyboardAppears = YES;
    self.navigationController.hidesBarsOnSwipe = YES;
   
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  20;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    
    return UIStatusBarStyleLightContent;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"abc" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    
    return cell;
    
    
}

@end
