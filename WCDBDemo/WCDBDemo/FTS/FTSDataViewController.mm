//
//  FTSDataViewController.m
//  WCDBDemo
//
//  Created by 杨帆 on 2021/1/24.
//  Copyright © 2021 JackLee. All rights reserved.
//

#import "FTSDataViewController.h"
#import <WCDB/WCDB.h>


@interface FTSDataViewController ()
@property (nonatomic,strong) WCTDatabase *databaseFTS;
@property (nonatomic,strong) NSString *tableNameFTS;

@end

@implementation FTSDataViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.tableNameFTS = @"tableNameFTS";
}



@end
