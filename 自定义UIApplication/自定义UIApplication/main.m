//
//  main.m
//  自定义UIApplication
//
//  Created by student on 2018/4/2.
//  Copyright © 2018年 student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TestApplication.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, NSStringFromClass([TestApplication class]), NSStringFromClass([AppDelegate class]));
    }
}
