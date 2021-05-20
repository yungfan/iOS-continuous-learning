//
//  ViewController.m
//  生成条形码
//
//  Created by 杨帆 on 2019/7/11.
//  Copyright © 2019 杨帆. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *barCodeImg;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    // 1. 实例化条形码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    // 2. 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 3. 将字符串转换成NSData
    NSData *data = [@"Hello World" dataUsingEncoding:NSUTF8StringEncoding];
    
    // 4. 通过KVC设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    
    // 5. 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    // 5.1 对CIImage进行转换 使得条形码变清晰
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(10, 10)];
    
    // 6. 将CIImage转换成UIImage
    UIImage *img =  [[UIImage alloc]initWithCIImage:outputImage];
    
    self.barCodeImg.image = img;
    
}


@end
