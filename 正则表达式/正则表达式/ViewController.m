//
//  ViewController.m
//  正则表达式
//
//  Created by yangfan on 2018/3/20.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //原始字符串
    NSString *searchText = @"ww15173265865dd";
    //正则表达式
    NSString *regex = @"1[358][0-9]{9}" ;
    NSError *error;
    //创建NSRegularExpression对象
    NSRegularExpression *express = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    
    if (error) {
        return;
    }
    
    //匹配查找
    [express enumerateMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        
        NSRange range =  result.range;
        NSLog(@"%@", [searchText substringWithRange:range]);
        
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
