//
//  Photo.m
//  PhotoData
//
//  Created by student on 2018/4/23.
//  Copyright © 2018年 objc.io. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(instancetype)initWithTitle:(NSString *)title Author:(NSString *)author
{
    
    if (self = [super init]) {
        
        _title = title;
        
        _author = author;
    }


    return self;

}

+(NSArray *)photos
{
    
    NSMutableArray *temp = [NSMutableArray array];

    for (int i  = 1; i < 20; i++)
    {
        
        
      [temp addObject:[[Photo alloc] initWithTitle:[NSString stringWithFormat:@"title-%d", i] Author:[NSString stringWithFormat:@"author-%d", i]]];

        
    }
    
    return temp;
}


@end
