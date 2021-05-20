//
//  ViewController.m
//  RunLoop的实际运用
//
//  Created by 杨帆 on 2019/4/1.
//  Copyright © 2019 杨帆. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) NSThread *thread;

@property (weak, nonatomic) IBOutlet UILabel *taskLb;

@property (assign, nonatomic) NSInteger count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.count = 0;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //[self timer];
    
    //[self imageDelay];
    
    [self threadNeverDie];
    
    // 利用performSelector，在self.thread的线程中调用task方法执行任务
    [self performSelector:@selector(task) onThread:self.thread withObject:nil waitUntilDone:NO];
}

// 使用一 NSTimer
-(void)timer {
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    //添加到NSRunLoopCommonModes模式 这样就不会在滑动的时候停掉
    //默认是NSDefaultRunLoopMode
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}


-(void)run {
 
    NSLog(@"Hello World");
    
}

// 使用二 ImageView推迟显示 - 特别适合在滚动列表的时候不加载图片 等停下来再加载
- (void)imageDelay {
    
    [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"img"] afterDelay:3.0 inModes:@[NSDefaultRunLoopMode]];
}


//使用三 常驻线程

- (void)threadNeverDie {
  
    // 创建线程，并调用run1方法执行任务
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(task) object:nil];
    
    self.thread = [[NSThread alloc]initWithBlock:^{
        
        // 在线程里面开启RunLoop，self.thread就变成了常驻线程，可随时添加任务，并交于RunLoop处理
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        
        [[NSRunLoop currentRunLoop] run];
        
    }];
    // 开启线程
    [self.thread start];
}

- (void)task {
    
    
    NSLog(@"%@", [NSThread currentThread]);

    NSLog(@"----start-----");
    
    NSLog(@"---- working----");
    
    NSLog(@"----end-----");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.count = self.count + 1;
        
        self.taskLb.text = [NSString stringWithFormat:@"%ld", (long)self.count];
        
    });
}
@end
