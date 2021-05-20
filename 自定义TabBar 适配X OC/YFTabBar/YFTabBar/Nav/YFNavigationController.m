//
//  YFNavigationController.m
//  YFTabbarController
//
//  Created by yangfan on 2018/3/13.
//  Copyright © 2018年 kangbing. All rights reserved.
//

#import "YFNavigationController.h"

@interface YFNavigationController ()

@end

@implementation YFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重写navC的pushVC方法，以便统一设置push进来的vc的左侧“返回”按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    

    //方案一 直接改bacYFarButtonItem
    //title为“”只有一个箭头
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //设置颜色
    self.navigationBar.tintColor = [UIColor blackColor];
    
    
    //这句会立即调用被push的VC的viewDidLoad方法，必须放在最后面，否则上面的代码会对viewDidLoad中代码造成覆盖，导致viewDidLoad设置无效。
    [super pushViewController:viewController animated:animated];//animated换为NO，所有VC没有动画
    
    //方案二 如果需要进一步定制 可以改为leftBarButtonItem
}



@end
