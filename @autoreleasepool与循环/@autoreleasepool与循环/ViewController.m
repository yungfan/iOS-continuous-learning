//
//  ViewController.m
//  @autoreleasepool与循环
//
//  Created by student on 2018/4/28.
//  Copyright © 2018年 student. All rights reserved.
//

#import "ViewController.h"

extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    //-[NSMutableArray addObject:] : 91334 ns
    //[self test1];
    
    //-[NSMutableArray addObject:] : 91063 ns
    //[self test2];
    
    //-[NSMutableArray addObject:] : 228841 ns
    [self test3];
    
}


- (void)test1 {
    
    
    size_t objectCount = 10000;
    
    uint64_t n = dispatch_benchmark(10000, ^{
        
        id obj = @1;
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (size_t i = 0; i < objectCount; ++i) {
            
            [array addObject:obj];
            
        }
        
    });
    
    NSLog(@"-[NSMutableArray addObject:] : %llu ns", n);
    
}



- (void)test2 {
    
    size_t objectCount = 10000;
    
    uint64_t n = dispatch_benchmark(10000, ^{
        
        @autoreleasepool {
            
            id obj = @1;
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (size_t i = 0; i < objectCount; ++i) {
                
                [array addObject:obj];
                
            }
        }
    });
    
    NSLog(@"-[NSMutableArray addObject:] : %llu ns", n);
}

- (void)test3 {
    
    size_t objectCount = 10000;
    
    uint64_t n = dispatch_benchmark(10000, ^{
        
        
        
        id obj = @1;
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (size_t i = 0; i < objectCount; ++i) {
            
            @autoreleasepool {
                
                [array addObject:obj];
            }
            
        }
        
    });
    
    NSLog(@"-[NSMutableArray addObject:] : %llu ns", n);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
