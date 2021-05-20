//
//  WCTSampleFTSData.m
//  WCDBDemo
//
//  Created by 杨帆 on 2021/1/24.
//  Copyright © 2021 JackLee. All rights reserved.
//

#import "WCTSampleFTSData.h"
#import <WCDB/WCDB.h>
#import "WCTSampleFTSData+WCTTableCoding.h"

@implementation WCTSampleFTSData

WCDB_IMPLEMENTATION(WCTSampleFTSData)

WCDB_SYNTHESIZE(WCTSampleFTSData, localID) // 表的字段实现
WCDB_SYNTHESIZE(WCTSampleFTSData, name)
WCDB_SYNTHESIZE(WCTSampleFTSData, content)
WCDB_SYNTHESIZE(WCTSampleFTSData, createTime)
WCDB_SYNTHESIZE(WCTSampleFTSData, autoIncrementIndex)
 
WCDB_VIRTUAL_TABLE_MODULE(WCTSampleFTSData, WCTModuleNameFTS3) // FTS版本
WCDB_VIRTUAL_TABLE_TOKENIZE(WCTSampleFTSData, WCTTokenizerNameWCDB) // 分词

WCDB_PRIMARY_AUTO_INCREMENT(WCTSampleFTSData, autoIncrementIndex) // 自增主键

@end
