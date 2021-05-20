//
//  ViewController.m
//  Unwind Segue使用
//
//  Created by student on 2018/4/2.
//  Copyright © 2018年 student. All rights reserved.


//具体传值步骤
//1. SB中完成两个界面的正向跳转
//2. 在获取值的界面写一个类似如右的方法。  -(IBAction)getValue:(UIStoryboardSegue *)sender
//3. 在该方法中进行判断和获取下个界面传过来的值
//4. SB中选中下个界面的Exit，并和2中的方法连线
//5. 连线以后左侧会多一个Unwind Segue，选中它设置identifier

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *strValue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//想获取值的界面写上如下函数
-(IBAction)getValue:(UIStoryboardSegue *)sender{
    
    if ([sender.identifier isEqualToString:@"unwindAB"]) {
        
        //注意这里是sourceViewController 不是destinationViewController
        SecondViewController *svc = sender.sourceViewController;
        
        //获取值
        self.strValue.text = svc.returnData;

    }
    
   
}


@end
