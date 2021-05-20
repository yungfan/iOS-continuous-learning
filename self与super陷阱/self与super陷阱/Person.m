//
//  Person.m
//  self与super陷阱
//
//  Created by yangfan on 2018/4/3.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "Person.h"

@implementation Person

-(void)printFatherInfo{
    
    NSLog(@"%@ %@ %@ %@",[self class], [self superclass], [super class], [super superclass]);
    
}

@end
