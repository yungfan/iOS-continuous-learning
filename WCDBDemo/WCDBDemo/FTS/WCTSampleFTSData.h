//
//  WCTSampleFTSData.h
//  WCDBDemo
//
//  Created by 杨帆 on 2021/1/24.
//  Copyright © 2021 JackLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WCTSampleFTSData : NSObject

@property(nonatomic, assign) NSInteger localID;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, strong) NSDate *createTime;
@property(nonatomic, assign) NSInteger autoIncrementIndex; // 该字段不参与逻辑，只是为了自增涨，记录最后一次插入的Id

@end

NS_ASSUME_NONNULL_END
