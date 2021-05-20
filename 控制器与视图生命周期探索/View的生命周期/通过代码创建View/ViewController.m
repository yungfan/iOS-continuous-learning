//
//  ViewController.m
//  通过代码创建View
//
//  Created by yangfan on 2018/3/22.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "ViewController.h"
#import "YFView.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)loadView{
    
    //YFView *yfView = [[YFView alloc]init];
    
    //YFView *yfView = [[YFView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"YFView" owner:nil options:nil];
    
    self.view = [array lastObject];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
