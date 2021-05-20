//
//  ViewController.m
//  UITableVIewSelfSizing
//
//  Created by 赵赤赤 on 2017/1/11.
//  Copyright © 2017年 mhz. All rights reserved.
//

#import "ViewController.h"
#import "YYFPSLabel.h"
#import "MessageCell.h"
#import "CellModel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) MessageCell *tempCell;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YYFPSLabel *fpsLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(0, 20, 60, 20)];
    [self.view addSubview:fpsLabel];
    
    // 创建TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    // 注册cell
    [self.tableView registerClass:[MessageCell class] forCellReuseIdentifier:@"MessageCell"];
    
    // 模拟一些数据源
    NSArray *nameArr = @[@"张三：",
                         @"李四：",
                         @"王五：",
                         @"陈六：",
                         @"钱七："];
    NSArray *messageArr = @[@"ash快点回家爱是妒忌哈市党和国家按时到岗哈时代光华撒国会大厦国会大厦国会大厦更好的噶山东黄金撒旦哈安师大噶是个混蛋撒",
                            @"傲世江湖点撒恭候大驾水草玛瑙现在才明白你个坏蛋擦边沙尘暴你先走吧出现在",
                            @"撒点花噶闪光灯",
                            @"按时间大公司大概好久撒大概好久撒党和国家按时到岗哈师大就萨达数据库化打算几点撒谎就看电视骄傲的撒金葵花打暑假工大撒比的撒谎讲大话手机巴士差距啊市场报价啊山东黄金as擦伤擦啊as擦肩时擦市场报价按时VC阿擦把持啊三重才撒啊双层巴士吃按时吃啊双层巴士擦报啥错",
                            @"as大帅哥大孤山街道安师大好噶时间过得撒黄金国度"];
    // 向数据源中随机放入500个Model
    self.dataArr = [[NSMutableArray alloc] init];
    for (int i=0; i<500; i++) {
        CellModel *model = [[CellModel alloc] init];
        model.name = nameArr[arc4random()%nameArr.count];
        model.message = messageArr[arc4random()%messageArr.count];
        [self.dataArr addObject:model];
    }
    
    // 我们再创建一个按钮，点击可从后面追加一些数据进来
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, 100, 40)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"添加" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
    
    // 创建
    self.tempCell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MessageCell"];
}

- (void)addData {
    // 添加一个Model，在追加到Tableview中
    CellModel *model = [[CellModel alloc] init];
    model.name = @"皮皮：";
    model.message = @"我是新追加的数据，666666";
    [self.dataArr addObject:model];
    
    // 插入到tableView中
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataArr.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    // 再滚动到最底部
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //取出当前的Model
    CellModel *model = self.dataArr[indexPath.row];
    //没有高度就计算
    if (model.cellHeight == 0) {
        CGFloat cellHeight = [self.tempCell heightForModel:model];
        
        // 缓存给model
        model.cellHeight = cellHeight;
        
        return cellHeight;
    } else {
        return model.cellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    cell.message = self.dataArr[indexPath.row];
    return cell;
}


@end
