//
//  TestApplication.m
//  自定义UIApplication
//
//  Created by student on 2018/4/2.
//  Copyright © 2018年 student. All rights reserved.
//

#import "TestApplication.h"
#import "ViewController.h"

@implementation TestApplication

-(BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event{

    
    //需要注意的是NSStringFromSelector(action)后面匹配方法名字的时候要加 :
    if ([target isKindOfClass:[ViewController class]] && [sender isKindOfClass:[UIButton class]] && [NSStringFromSelector(action) isEqualToString:@"logOut:"]) {
        
        
        NSLog(@"%s ----- logOut 用户退出了", __func__);
        
        
    }

    if ([target isKindOfClass:[ViewController class]] && [sender isKindOfClass:[UIButton class]] && [NSStringFromSelector(action) isEqualToString:@"logIn:"]) {
        
        
        
        
        NSLog(@"%s ----- logIn 用户登录了", __func__);
        
        
    }

    
    return [super sendAction:action to:target from:sender forEvent:event];

}

//- (void)sendEvent:(UIEvent *)event{
//
//     NSLog(@"%s", __func__);
//    
//     [super sendEvent:event];
//    
//}

@end
