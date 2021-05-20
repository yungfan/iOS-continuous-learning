//
//  LoginViewController.h
//  YFTabBar
//
//  Created by student on 2018/4/27.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFTabbarController.h"


@protocol passValue <NSObject>
-(void)setSelectedVC;
@end

@interface LoginViewController : UIViewController

@property(nullable, nonatomic,weak) id<passValue> delegate;

@end
