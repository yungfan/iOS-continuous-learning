//
//  nextViewController.m
//  转屏控制
//
//  Created by mac on 14/12/2.
//  Copyright (c) 2014年 WangWei. All rights reserved.
//

#import "nextViewController.h"

@interface nextViewController ()

@end

@implementation nextViewController

//最不能理解的地方在这里，按照网上各种开发人员的说法，该方法应该是由自己的导航控制器控制的（除非该控制器是根控制器），不知道为什么pop到这里后非要调用一下它的重载才能生效

-(void)viewDidLoad
{
    NSLog(@"second.......");
    self.title=@"second";
}
@end
