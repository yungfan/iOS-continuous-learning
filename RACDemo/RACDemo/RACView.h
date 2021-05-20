//
//  RACView.h
//  RACDemo
//
//  Created by 首牛科技 on 2018/1/29.
//  Copyright © 2018年 ShouNew.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>
@interface RACView : UIView

@property (nonatomic,strong)RACSubject *btnClickSingle;

//demo4用
-(void)sendValue:(NSString *)str andDic:(NSDictionary *)dic;
@end
