//
//  main.m
//  self与super陷阱
//
//  Created by yangfan on 2018/4/3.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Son.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Person *p = [Person new];
        
        Son *s = [Son new];
 
        
        [s printSonInfo];
        
        
        [p printFatherInfo];
        
        
        
        
        
    }
    return 0;
}
