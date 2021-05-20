//
//  ViewController.m
//  AvoidTagAbuse
//
//  Created by Vienta on 14-6-30.
//  Copyright (c) 2014年 www.vienta.me. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>


@interface ViewController ()
{
    NSMutableArray *_photoArr;
    UIImageView *_photoIgv;
}

@end

@implementation ViewController

static char kTagButtonAssociatedPhoteKey;


/**
 * Associated Ojbects 是Objective-C 2.0运行时功能，具体作用就是让对象在运行时关联任何值。
 */
- (void)setAssociatedImage:(UIImage *)image
                forButton:(UIButton *)button
{
    objc_setAssociatedObject(button,
                             &kTagButtonAssociatedPhoteKey,
                             image,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)associatedImageForButton:(UIButton *)button
{
    return objc_getAssociatedObject(button,
                                    &kTagButtonAssociatedPhoteKey);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _photoIgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 220)];
    [self.view addSubview:_photoIgv];

    for (int idx = 0; idx < 7; idx ++) {
        
        NSString *imgName = [NSString stringWithFormat:@"btn%d",idx+1];
        UIImage *img = [UIImage imageNamed:imgName];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:imgName forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 60, 30);
        btn.center = CGPointMake(160, 260 + 45*idx);
        btn.backgroundColor = [UIColor blackColor];
        [btn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        [self setAssociatedImage:img forButton:btn];
        
    }
}

- (void)tapBtn:(id)sender
{
    UIButton *btn = (id)sender;
    
    UIImage *img = [self associatedImageForButton:btn];
    
    [_photoIgv setImage:img];
}


@end
