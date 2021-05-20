//
//  ViewController.m
//  C++支持
//
//  Created by 杨帆 on 2019/9/9.
//  Copyright © 2019 杨帆. All rights reserved.
//

#import "ViewController.h"
#import "Mp3Encoder.hpp"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Mp3Encoder *encoder = new Mp3Encoder();
    
    encoder->encode();
    
    delete encoder;
}


@end
