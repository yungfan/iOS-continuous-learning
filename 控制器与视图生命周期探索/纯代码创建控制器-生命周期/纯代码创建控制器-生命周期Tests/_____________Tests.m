//
//  _____________Tests.m
//  纯代码创建控制器-生命周期Tests
//
//  Created by yangfan on 2018/3/22.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface _____________Tests : XCTestCase

@end

@implementation _____________Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
