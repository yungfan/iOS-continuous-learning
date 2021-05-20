//
//  YFViewController.m
//  创建控制器勾选XIB
//
//  Created by yangfan on 2018/3/22.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "YFViewController.h"

@interface YFViewController ()

@end

@implementation YFViewController

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
    
    NSLog(@"%s", __func__);
    
    [super awakeFromNib];
    
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
