//
//  WCTSampleFTSData+WCTTableCoding.h
//  WCDBDemo
//
//  Created by 杨帆 on 2021/1/24.
//  Copyright © 2021 JackLee. All rights reserved.
//

#import "WCTSampleFTSData.h"
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCTSampleFTSData (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(localID) // 表的字段声明
WCDB_PROPERTY(name)
WCDB_PROPERTY(content)
WCDB_PROPERTY(createTime)
WCDB_PROPERTY(autoIncrementIndex)

@end

NS_ASSUME_NONNULL_END
