//
//  ViewController.m
//  NSCalendar使用
//
//  Created by 杨帆 on 2019/5/29.
//  Copyright © 2019 杨帆. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


+ (NSString *)checkTheDate:(NSString *)string{
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    
    [format setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [format dateFromString:string];
    
    BOOL isToday = [[NSCalendar currentCalendar] isDateInToday:date]; //判断一个日期是否是今天
    
    BOOL isYesterday = [[NSCalendar currentCalendar] isDateInYesterday:date]; //判断一个日期是否是昨天
    
    BOOL isTomorrow = [[NSCalendar currentCalendar] isDateInTomorrow:date]; //判断一个日期是否是明天
    
    BOOL isWeekend = [[NSCalendar currentCalendar] isDateInWeekend:date]; //判断一个日期是否是属于周末双休日
    
    BOOL isSameDay = [[NSCalendar currentCalendar] isDate:date inSameDayAsDate:[[NSDate alloc]init]]; //判断一个日期和另外一个是否相等
    
    NSString *strDiff = nil;
    
    if(isToday) {
        
        strDiff= [NSString stringWithFormat:@"今天"];
    }
    return strDiff;
}

@end
