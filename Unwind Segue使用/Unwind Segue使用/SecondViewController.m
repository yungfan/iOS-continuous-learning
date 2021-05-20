//
//  SecondViewController.m
//  Unwind Segue使用
//
//  Created by student on 2018/4/2.
//  Copyright © 2018年 student. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

- (IBAction)passValue:(id)sender;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (IBAction)passValue:(id)sender {
    
    self.returnData = @"第二个界面回传的值";
}
@end
