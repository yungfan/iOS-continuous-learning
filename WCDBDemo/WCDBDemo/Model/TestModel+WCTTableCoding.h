//
//  TestModel+WCTTableCoding.h
//  WCDBDemo
//
//  Created by 杨帆 on 2021/1/24.
//  Copyright © 2021 JackLee. All rights reserved.
//

#import "TestModel.h"
#import <WCDB/WCDB.h>

@interface TestModel (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(name)
WCDB_PROPERTY(modelID)

@end
