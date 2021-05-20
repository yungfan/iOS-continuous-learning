//
//  ViewController.m
//  鱼眼全景图
//
//  Created by 杨帆 on 2019/5/8.
//  Copyright © 2019 杨帆. All rights reserved.
//

#import "ViewController.h"
#import "YQPanoramaView.h"

@interface ViewController ()

@property (nonatomic, strong) YQPanoramaView *panaromview;

- (IBAction)go:(id)sender;

- (IBAction)back:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化
    self.panaromview = [[YQPanoramaView alloc]initWithFrame:self.view.bounds];
    
    //设图片
    self.panaromview.image = [UIImage imageNamed:@"1-203 A.jpg"];
    
    //显示
    [self.view insertSubview:self.panaromview atIndex:0];
}

- (IBAction)go:(id)sender {
    
    self.panaromview.image = [UIImage imageNamed:@"1-203 B.jpg"];
}

- (IBAction)back:(id)sender {
    
    self.panaromview.image = [UIImage imageNamed:@"1-203 A.jpg"];
}
@end
