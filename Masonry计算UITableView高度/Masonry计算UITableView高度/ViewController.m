//
//  ViewController.m
//  Masonry计算UITableView高度
//
//  Created by yangfan on 2018/3/29.
//  Copyright © 2018年 yangfan. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray *dataSouse;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"OC自适应高度";
    
    //数据
    NSArray * array = @[@"我就两个字",@"中新网4月17日电  据韩联社报道，韩国海洋水产部(简称“海水部”)“世越号”现场处理本部和负责世越号船体清理工作的韩国打捞局(Korea Salvage)为方便搜寻失踪者遗体的工作人员开展工作已于17日完成护栏安装，预计失踪者遗体搜寻工作有望于18日正式启动",@"这是第三个",@"3月28日，在将“世越”号船体运往木浦新港前，工作人员也同样在半潜船甲板上发现过动物尸骨。本月2日，工作人员曾在半潜船甲板上发现9块动物尸骨、“世越”号船长李某的护照及手提包、信用卡、圆珠笔等物品，但截至目前仍未发现9名失踪者的遗体。",@"",@"2014年4月16日，“世越”号在全罗南道珍岛郡附近水域沉没，共致295人遇难，迄今仍有9人下落不明，遇难者大多是学生。"];
    [self.dataSouse addObjectsFromArray:array];
    
    [self tableView];
}

- (NSMutableArray *)dataSouse{
    
    if (_dataSouse == nil) {
        _dataSouse = [NSMutableArray array];
    }
    return _dataSouse;
}


//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,  self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:_tableView];
        
        //开启自动计算高度
        //【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;

    }
    
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouse.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifierhot = @"cell";
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierhot];
    if (!cell){
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierhot];
        /* 忽略点击效果 */
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    
    cell.stringTitle = self.dataSouse[indexPath.row];
    
    return cell;
    
}

@end
