//
//  UserModel.m
//  YFTabbarController
//
//  Created by student on 2018/3/21.
//  Copyright © 2018年 kangbing. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

static UserModel * _instance = nil;

+(instancetype) shareInstance{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone{
    return [UserModel shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone{
    return [UserModel shareInstance] ;
}

@end
