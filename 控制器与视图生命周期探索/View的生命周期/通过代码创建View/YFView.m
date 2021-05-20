//
//  YFView.m
//  通过代码创建View
//
//  Created by yangfan on 2018/3/22.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "YFView.h"

@implementation YFView

-(instancetype)init{
    
    self = [super init];
    
    NSLog(@"%s", __func__);
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:(CGRect)frame];
    
    NSLog(@"%s", __func__);
    
    return self;
    
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    NSLog(@"%s", __func__);
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    NSLog(@"%s", __func__);
    
    return self;
    
}

-(void)layoutSubviews{
    
    NSLog(@"%s", __func__);
    
}

@end
