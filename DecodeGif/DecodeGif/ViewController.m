//
//  ViewController.m
//  DecodeGif
//
//  Created by 杨帆 on 2019/10/16.
//  Copyright © 2019 杨帆. All rights reserved.
//

#import "ViewController.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreservices/MobileCoreServices.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self deCompositionGif];
}

-(void)deCompositionGif{
    
    // 加载GIF数据
    NSString *gifPathSource = [[NSBundle mainBundle]pathForResource:@"1" ofType:@"gif"];
    
    NSData *data = [NSData dataWithContentsOfFile:gifPathSource];
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    // 分解
    size_t count = CGImageSourceGetCount(source);
    
    NSMutableArray *tempArry = [[NSMutableArray alloc]init];
    
    for (size_t i = 0; i < count; i++) {
        
        CGImageRef imageref = CGImageSourceCreateImageAtIndex(source, i, NULL);
        
        //将一张张图片转化为UIImage
        UIImage *image = [UIImage imageWithCGImage:imageref];
        
        [tempArry addObject:(image)];
    }
    
    CFRelease(source);
    
    // 单张图片保存
    for (int i = 0; i < tempArry.count; i++) {
        
        NSData *data = UIImagePNGRepresentation(tempArry[i]);
        
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *gifPath = path[0];
        
        NSLog(@"%@", gifPath);
        
        NSString *pathNum = [gifPath stringByAppendingString:[NSString stringWithFormat:@"%d.png",i]];
        
        [data writeToFile:pathNum atomically:YES];
    }
    
    
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
