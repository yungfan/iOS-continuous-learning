//
//  RACView.m
//  RACDemo
//
//  Created by 首牛科技 on 2018/1/29.
//  Copyright © 2018年 ShouNew.com. All rights reserved.
//

#import "RACView.h"

@implementation RACView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        //创建一个按钮
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 70, 70)];
        btn.backgroundColor = [UIColor redColor];
        [self addSubview:btn];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            //发送信号
//            [self.btnClickSingle sendNext:@"按钮点击咯"];//这句代码时demo3的
            [self sendValue:@"1234" andDic:@{@"key":@"value"}];//这句是demo4的

        }];
    }
    return self;
}
-(RACSubject *)btnClickSingle{
    if (!_btnClickSingle) {
        _btnClickSingle = [RACSubject subject];
    }
    return _btnClickSingle;
}
-(void)sendValue:(NSString *)str andDic:(NSDictionary *)dic{
    
}
@end
