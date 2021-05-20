//
//  ViewController.m
//  通过SB创建控制器
//
//  Created by yangfan on 2018/3/22.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)loadView{
    
    NSLog(@"%s", __func__);
    
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%s", __func__);
    
    self.view.backgroundColor = [UIColor redColor];
}


-(void)viewDidAppear:(BOOL)animated{
    
    NSLog(@"%s", __func__);
    
    [super viewDidAppear:animated];
    
    
}

-(instancetype)init{
    
    self = [super init];
    
    NSLog(@"%s", __func__);
    
    return self;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    NSLog(@"%s", __func__);
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil];
    
    NSLog(@"%s", __func__);
    
    return self;
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    NSLog(@"%s", __func__);
    
    return self;
    
}


@end
