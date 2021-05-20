//
//  YFTabbar.m
//  YFTabbarController
//
//  Created by kangbing on 16/5/31.
//  Copyright © 2016年 kangbing. All rights reserved.
//

#import "YFTabbar.h"

//屏幕宽高
#define XSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define XSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//iPhone X
#define Is_iPhoneX (XSCREEN_WIDTH == 375.f && XSCREEN_HEIGHT == 812.f)

//安全区域的顶部和底部
#define SafeAreaTopHeight (XSCREEN_HEIGHT == 812.0 ? 88 : 64)
#define SafeAreaBottomHeight (XSCREEN_HEIGHT == 812.0 ? 34 : 0)


@interface YFTabbar ()

/** 记录上一次被点击按钮的tag */
@property (nonatomic, assign) NSInteger previousClickedTag;

@end

@implementation YFTabbar


//构造函数里面添加中间按钮
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"plus_Last"] forState:UIControlStateNormal];
        
        [btn sizeToFit];
        
        self.centerBtn = btn;
        
        [self addSubview:btn];
        
        
    }
    return self;
}

//重新布局
- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    int w = self.bounds.size.width;
    //iPhone X Tab的高度为83 普通的为49 所以差了一个34 为安全局域的范围
    int h = Is_iPhoneX? self.bounds.size.height - SafeAreaBottomHeight : self.bounds.size.height;
    
    self.centerBtn.center = CGPointMake(w * 0.5, h * 0.3);
    
    NSInteger index = 0;
        
    CGFloat width = w / (self.vcCount + 1);
        
    for (UIButton * tabBarButton in self.subviews) {
            
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            //监听tabbar的点击
            //绑定tag 标识
            tabBarButton.tag = index;
            
            //监听tabbar的点击
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
                
            tabBarButton.frame = CGRectMake(index * width, self.bounds.origin.y, width, h);
            
            //NSLog(@"%@", NSStringFromCGRect(sub.frame));
                
                index++;
            
                if (index == self.vcCount/2) {
                    
                    index++;
            }
        }
    }
    // 将“+”按钮放到视图层次最前面
    [self bringSubviewToFront:self.centerBtn];
}

#pragma mark -- tabbar按钮的点击
- (void)tabBarButtonClick:(UIControl *)tabBarBtn{
    
    //判断当前按钮是否为上一个按钮
    //再次点击同一个item时发送通知出去 对应的VC捕获并判断
    if (self.previousClickedTag == tabBarBtn.tag) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:
         @"DoubleClickTabbarItemNotification" object:@(tabBarBtn.tag)];
    }
    self.previousClickedTag = tabBarBtn.tag;
}


//重写hitTest方法，去监听"+"按钮和“添加”标签的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    
    //这一个判断是关键，不判断的话push到其他页面，点击“+”按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有TabBar的，那么肯定是在根控制器页面
    //在根控制器页面，那么我们就需要判断手指点击的位置是否在“+”按钮或“添加”标签上
    //是的话让“+”按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前TabBar的触摸点转换坐标系，转换到“+”按钮的身上，生成一个新的点
        CGPoint newPoint = [self convertPoint:point toView:self.centerBtn];
        
        //判断如果这个新的点是在“+”按钮身上，那么处理点击事件最合适的view就是“+”按钮
        if ( [self.centerBtn pointInside:newPoint withEvent:event]) {
            
            return self.centerBtn;
            
        }
        
        //如果点不在“+”按钮身上，直接让系统处理就可以了
        else{
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    //TabBar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
    else {
        return [super hitTest:point withEvent:event];
    }
}


@end
