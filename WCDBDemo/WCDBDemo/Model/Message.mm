//
//  Message.mm
//  WCDBDemo
//
//  Created by 杨帆 on 2021/1/24.
//  Copyright © 2021 JackLee. All rights reserved.
//

#import "Message+WCTTableCoding.h"
#import "Message.h"
#import <WCDB/WCDB.h>
// 在.m文件中需要定义类文件中绑定到数据库表的字段以及主键的设置、索引的设置以及约束等
@implementation Message

WCDB_IMPLEMENTATION(Message) // 表

WCDB_SYNTHESIZE(Message, localID) // 表的字段
WCDB_SYNTHESIZE(Message, content)
WCDB_SYNTHESIZE(Message, createTime)
WCDB_SYNTHESIZE(Message, modifiedTime)
WCDB_SYNTHESIZE(Message, age)

WCDB_PRIMARY(Message, localID) // 主键

WCDB_INDEX(Message, "_index", createTime) // 索引

@end
