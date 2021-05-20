//
//  YFTabbar.h
//  YFTabbarController
//
//  Created by kangbing on 16/5/31.
//  Copyright © 2016年 kangbing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTabbar : UITabBar

//中间按钮
@property (nonatomic, strong) UIButton *centerBtn;

//总的VC数，用于平分宽度
@property (nonatomic, assign) NSUInteger vcCount;

@end
