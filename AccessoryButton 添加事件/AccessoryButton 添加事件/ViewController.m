//
//  ViewController.m
//  AccessoryButton 添加事件
//
//  Created by 杨帆 on 2018/8/11.
//  Copyright © 2018年 杨帆. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"abc" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    //右侧的五种附加视图，只有Button的才可以响应如下的代理事件 否则需要自定义
    //UITableViewCellAccessoryNone,
    //UITableViewCellAccessoryDisclosureIndicator,
    //UITableViewCellAccessoryDetailDisclosureButton
    //UITableViewCellAccessoryCheckmark
    //UITableViewCellAccessoryDetailButton
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld", indexPath.row);
    
    
}
@end
