//
//  Message.h
//  WCDBDemo
//
//  Created by 杨帆 on 2021/1/24.
//  Copyright © 2021 JackLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

// 将需要暴露的属性暴露出来，以供其他类使用
@property(nonatomic, assign) NSInteger localID;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, strong) NSDate *createTime;
@property(nonatomic, strong) NSDate *modifiedTime;
@property(nonatomic, assign) NSInteger age;

@end
