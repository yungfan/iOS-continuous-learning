//
//  UserModel.h
//  YFTabbarController
//
//  Created by student on 2018/3/21.
//  Copyright © 2018年 kangbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property(nonatomic, assign) BOOL isLogin;

+(instancetype) shareInstance;

@end
