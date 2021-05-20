//
//  Photo.h
//  PhotoData
//
//  Created by student on 2018/4/23.
//  Copyright © 2018年 objc.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *author;

-(instancetype)initWithTitle:(NSString *)title Author:(NSString *)author;

+(NSArray *)photos;

@end
