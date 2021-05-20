//
//  MessageCell.h
//  UITableVIewSelfSizing
//
//  Created by 赵赤赤 on 2017/1/11.
//  Copyright © 2017年 mhz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellModel.h"

@interface MessageCell : UITableViewCell

@property (nonatomic, strong) CellModel *message;

- (CGFloat)heightForModel:(CellModel *)message;

@end
