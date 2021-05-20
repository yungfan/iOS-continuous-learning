//
//  Message+WCTTableCoding.h
//  WCDBDemo
//
//  Created by 杨帆 on 2021/1/24.
//  Copyright © 2021 JackLee. All rights reserved.
//

#import "Message.h"
#import <WCDB/WCDB.h>

// 用Category特性将WCDB的引用隔离。遵守WCTTableCoding协议，使用WCDB_PROPERTY将声明绑定到数据库表的字段。

@interface Message (WCTTableCoding) <WCTTableCoding>

// WCDB_PROPERTY用于在头文件中声明绑定到数据库表的字段。
WCDB_PROPERTY(localID)
WCDB_PROPERTY(content)
WCDB_PROPERTY(createTime)
WCDB_PROPERTY(modifiedTime)
WCDB_PROPERTY(age)

@end
