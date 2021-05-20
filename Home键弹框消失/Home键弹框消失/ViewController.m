//
//  ViewController.m
//  Home键弹框消失
//
//  Created by 杨帆 on 2018/8/23.
//  Copyright © 2018年 杨帆. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIAlertController *alertController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // 监听进入后台的通知 然后dismiss掉弹出的窗口
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissAlertViewController:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
}

- (void)dismissAlertViewController:(NSNotification *)notification{
    
    [_alertController dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    _alertController = [UIAlertController alertControllerWithTitle:@"Alert Title"
                                                           message:@"The message is Alert"
                                                    preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"OK Action");
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"Cancel Action");
    }];
    
    [_alertController addAction:okAction];
    
    [_alertController addAction:cancelAction];
    
    
    [self presentViewController:_alertController animated:YES completion:nil];
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:self];
}
@end
