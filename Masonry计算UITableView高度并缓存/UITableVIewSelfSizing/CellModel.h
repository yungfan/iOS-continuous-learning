//
//  CellModel.h
//  UITableVIewSelfSizing
//
//  Created by 赵赤赤 on 2017/1/11.
//  Copyright © 2017年 mhz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CellModel : NSObject

// 姓名
@property (nonatomic, copy) NSString *name;
// 发言内容
@property (nonatomic, copy) NSString *message;
// 该Model对应的Cell高度
@property (nonatomic, assign) CGFloat cellHeight;

@end
