//
//  ViewController.m
//  监听系统音量变化
//
//  Created by 杨帆 on 2019/7/8.
//  Copyright © 2019 杨帆. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //监听系统音量
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChangeNotification:)name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
}

//系统音量回调
- (void)volumeChangeNotification:(NSNotification *)noti {
    float volume = [[[noti userInfo] objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
    NSLog(@"系统音量:%f", volume);
}


@end
