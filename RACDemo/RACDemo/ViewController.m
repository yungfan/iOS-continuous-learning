//
//  ViewController.m
//  RACDemo
//
//  Created by 首牛科技 on 2018/1/29.
//  Copyright © 2018年 ShouNew.com. All rights reserved.
//

#import "ViewController.h"

#import <ReactiveObjC.h>
#import "RACView.h"
@interface ViewController ()
@property (nonatomic,assign)int time;
@property (nonatomic,strong)RACDisposable *disposable;
@property (nonatomic,strong)RACSignal *signal;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self demo1];
    
    
}
#pragma mark -- 监听事件(按钮点击)
-(void)demo1{
    //创建一个按钮
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 70, 70)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    btn.tag = 1001;
    //监听点击事件
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"按钮点击了%@",x);
    }];
}
#pragma mark -- 代替KVO
-(void)demo2{
    //创建一个按钮
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 70, 70)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    //监听点击事件
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        //改变btn的Frame
        x.frame = CGRectMake(100,100,200, 200);
    }];
    [[btn rac_valuesAndChangesForKeyPath:@"frame" options:(NSKeyValueObservingOptionNew) observer:self] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        //RACTwoTuple是一个集合类型，可以用数组的方式获取到里面的内容。
        NSLog(@"frame改变了%@",x.second);
    }];
    //这样的KVO你可以觉得好像并没有多了不起，那你看看demo3。
}
#pragma mark -- 代替代理，例如检测cell里某个view传值到controller
//只能代替没有返回值的代理
-(void)demo3{
    RACView *racView = [[RACView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.view addSubview:racView];
    //替代了代理把值从racView中传了过来。
    [racView.btnClickSingle subscribeNext:^(id  _Nullable x) {
        //要传多个值，，可以传一个集合
        NSLog(@"%@",x);
    }];
}
#pragma mark -- 代替代理，简化传值
-(void)demo4{
    //监听指定的某个方法传参
    RACView *racView = [[RACView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.view addSubview:racView];
    [[racView rac_signalForSelector:@selector(sendValue:andDic:)] subscribeNext:^(RACTuple * _Nullable x) {
        //当有多个参数传递时，传递过来的是集合，假如要取集合中某个元素的内容，可以用一下方式
        
        NSLog(@"按钮点击了%@",x.first);
    }];
}
#pragma mark -- 代替通知
-(void)demo5{
    //创建一个文本输入框
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(50, 50, 200, 50)];
    field.backgroundColor = [UIColor grayColor];
    [self.view addSubview:field];
    
    // 监听键盘弹出事件
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@", x);
    }];
}
#pragma mark -- 监听文本框的文字改变
-(void)demo6{
    //创建一个文本输入框
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(50, 50, 200, 50)];
    field.backgroundColor = [UIColor grayColor];
    [self.view addSubview:field];
    [field.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"文字改变了%@",x);
    }];
}
#pragma mark -- 代替timer循环执行某个方法
-(void)demo7{
    [[RACSignal interval:1.0 onScheduler:[RACScheduler scheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
}
#pragma mark -- RAC代替timer实现登录验证码倒计时
-(void)demo8{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 70, 200, 50)];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"发送验证码" forState:(UIControlStateNormal)];
    [self.view addSubview:btn];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.time = 10;
        btn.enabled = NO;
        [btn setTitle:[NSString stringWithFormat:@"请稍等%d秒",_time] forState:UIControlStateDisabled];
        _disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
            //减去时间
            _time --;
            //设置文本
            NSString *text = (_time > 0) ? [NSString stringWithFormat:@"请稍等%d秒",_time] : @"重新发送";
            if (_time > 0) {
                btn.enabled = NO;
                [btn setTitle:text forState:UIControlStateDisabled];
            }else{
                btn.enabled = YES;
                [btn setTitle:text forState:UIControlStateNormal];
                //关掉信号
                [_disposable dispose];
            }
            
        }];
    }];
    
}
#pragma mark -- 一个方法同时接受多个信号
-(void)demo9{
    // 处理多个请求，都返回结果的时候，统一做处理.
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求1
        [subscriber sendNext:@"发送请求1"];
        return nil;
    }];
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 发送请求2
        [subscriber sendNext:@"发送请求2"];
        return nil;
    }];
    
    // 使用注意：几个信号，selector的方法就几个参数，每个参数对应信号发出的数据。
    // 不需要订阅:不需要主动订阅,内部会主动订阅
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1,request2]];
    
}
// 更新UI
- (void)updateUIWithR1:(id)data r2:(id)data1
{
    NSLog(@"更新UI%@ %@",data,data1);
}

#pragma mark --ReactiveObjC中常用的宏
-(void)demo10{
    // RACObserve(就是一个宏定义):快速的监听某个对象的某个属性改变
    // 监听self.view的center属性,当center发生改变的时候就会触发NSLog方法
    [RACObserve(self.view, center) subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}
-(void)demo11{
    //用来给某个对象的某个属性绑定信号，只要产生信号内容，就会把内容给属性赋值
    //创建一个文本输入框
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(50, 120, 200, 50)];
    field.backgroundColor = [UIColor grayColor];
    [self.view addSubview:field];
    //创建一个label
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 200, 50)];
    [self.view addSubview:label];
    //将输入框内容给label
    RAC(label,text) = field.rac_textSignal;
}
-(void)demo12{
    //登录按钮的状态根据账号和密码输入框内容的长度来改变
    UITextField *userNameTF = [[UITextField alloc]initWithFrame:CGRectMake(40, 70, 200, 50)];
    UITextField *passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(40, 130, 200, 50)];
    userNameTF.placeholder = @"请输入用户名";
    passwordTF.placeholder = @"请输入密码";
    [self.view addSubview:userNameTF];
    [self.view addSubview:passwordTF];
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, 180, 200, 50)];
    [loginBtn setTitle:@"马上登录" forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    //根据textfield的内容来改变登录按钮的点击可否
    RAC(loginBtn, enabled) = [RACSignal combineLatest:@[userNameTF.rac_textSignal, passwordTF.rac_textSignal] reduce:^id _Nullable(NSString * username, NSString * password){
        return @(username.length >= 11 && password.length >= 6);
    }];
    //根据textfield的内容来改变登录按钮的背景色
    RAC(loginBtn, backgroundColor) = [RACSignal combineLatest:@[userNameTF.rac_textSignal, passwordTF.rac_textSignal] reduce:^id _Nullable(NSString * username, NSString * password){
        return (username.length >= 11 && password.length >= 6) ? [UIColor redColor] : [UIColor grayColor];
    }];
    
}
-(void)demo13{
    //避免循环引用，外部@weakify(self)，内部@strongify(self)
    // @weakify() 宏定义
    @weakify(self) //相当于__weak typeof(self) weakSelf = self;
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)  //相当于__strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"%@",self.view);
        return nil;
    }];
    _signal = signal;
}













@end
