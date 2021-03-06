//
//  TwoViewController.m
//  YFTabbarController
//
//  Created by kangbing on 16/5/31.
//  Copyright © 2016年 kangbing. All rights reserved.
//

#import "TwoViewController.h"
#import "AFNetworking.h"
#import "News.h"
#import "DetailsViewController.h"
#import "NewsCell.h"

@interface TwoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *newsTableView;

@property(nonatomic, strong) NSMutableArray *newsData;

@end

@implementation TwoViewController


-(NSMutableArray *)newsData{
    
    if (_newsData == nil) {
        
        _newsData = [NSMutableArray array];
        
        [self loadData];
        
    }
    
    return _newsData;
}


//网络加载数据
-(void)loadData{
    
    //发送网络请求
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"https://jrwh.wuhunews.cn/server/e/news/newslist?type=1&category=0"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    //获取网络数据（JSON转对象 对象添加到数据源）
    //AF回调看上去和NSUYRLSession差不多，但是它的回调式直接在主线程中的，所以不需要主动回到主线程
    NSURLSessionDataTask *dataTask  =  [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        //responseObject就是返回的数据，返回的是dic就是dic，返回的是array就是array，无需转换
        //获取新闻列表
        NSArray *array = responseObject[@"list"];
        
        //数组转模型
        for (int i = 0; i < array.count; i++) {
            
            
            //Mantle MJExtension YYModel
            NSDictionary *dic = array[i];
            News *news = [[News alloc]init];
            news.title = dic[@"title"];
            news.cover = dic[@"cover"];
            news.url = dic[@"url"];
            
            [_newsData addObject:news];
            
            
        }
        
        [self.newsTableView reloadData];
        //加载数据完毕停止刷新
        if ([self.newsTableView.refreshControl isRefreshing]) {
            
            [self.newsTableView.refreshControl endRefreshing];
        }
        
    }];
    
    [dataTask resume];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    //捕获“双击”通知 可以做刷新、回滚
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(doubleClickTab:) name:@"DoubleClickTabbarItemNotification" object:nil];
    
}

-(void)doubleClickTab:(NSNotification *)notification{
    
    
    //这里有个坑 就是直接用NSInteger接收会有问题 数字不对
    //因为上个界面传过来的时候封装成了对象，所以用NSNumber接收后再取值
    NSNumber *index = notification.object;
    
    if ([index intValue] == 1) {
        
        //刷新
        //下拉更新有两个陷阱：1. 调用- beginRefreshing方法不会触发UIControlEventValueChanged事件；2. 调用- beginRefreshing方法不会自动显示进度圈。
        
        
        //先回到顶部
        [UIView animateWithDuration:0.1 animations:^{

           [self.newsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            
            
        } completion:^(BOOL finished) {
            
            //animated不要为YES，否则菊花会卡死
            [self.newsTableView setContentOffset:CGPointMake(0, self.newsTableView.contentOffset.y - self.newsTableView.refreshControl.frame.size.height) animated:NO];
            
            
            [self.newsTableView.refreshControl beginRefreshing];
            
            [self refreshTabView];
            
        }];
        
       
    }
    
}

-(void)setupUI{
    
    //防止Tab底部遮住UITableView的解决办法之一
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-SafeAreaBottomHeight);
    
    UITableView *newsTab = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    
    newsTab.dataSource = self;
    
    newsTab.delegate = self;
    
    newsTab.showsVerticalScrollIndicator = NO;
    
    [newsTab registerClass:[NewsCell class] forCellReuseIdentifier:@"newsCell"];
    
    newsTab.estimatedRowHeight = 100;
    newsTab.rowHeight = UITableViewAutomaticDimension;
    
    //创建刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    refreshControl.tintColor = [UIColor grayColor];
    
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    
    [refreshControl addTarget:self action:@selector(refreshTabView) forControlEvents:UIControlEventValueChanged];
    
    newsTab.refreshControl = refreshControl;
    
    
    //进来时就开始刷新
    [newsTab.refreshControl beginRefreshing];
    
    [self.view addSubview:newsTab];
    
    self.newsTableView = newsTab;
    
}

// 下拉刷新
-(void)refreshTabView
{
    //随机添加一条数据
    NSUInteger i = arc4random() % self.newsData.count;
    
    [self.newsData insertObject:[self.newsData objectAtIndex:i] atIndex:0];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if ([self.newsTableView.refreshControl isRefreshing]) {
            
            [self.newsTableView.refreshControl endRefreshing];
        }
        
        //不用reload 直接插入一条 不用全局刷新了
        [self.newsTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
        //回到顶部
        [self.newsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    });
}

// 加载更多
-(void)loadMore
{
    //随机添加一条数据
    NSUInteger i = arc4random() % self.newsData.count;
    
    [self.newsData addObject:[self.newsData objectAtIndex:i]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if ([self.newsTableView.refreshControl isRefreshing]) {
            
            [self.newsTableView.refreshControl endRefreshing];
        }
        
        [self.newsTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.newsData.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
        // 再滚动到最底部
        [self.newsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.newsData.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    });
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.newsData.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell" forIndexPath:indexPath];
    
    cell.news = [self.newsData objectAtIndex:indexPath.row];
    
    return cell;
    
}


//下面两个方法必须成对出现才有效果
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @" ";
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, XSCREEN_WIDTH, 44)];
    [btn setTitle:@"加载更多" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor darkGrayColor];
    
    [btn addTarget:self action:@selector(loadMore) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击cell抬起手指之后，就没有那个选中的灰色背景颜色
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    DetailsViewController *details = [[DetailsViewController alloc]init];
    
    News* news = [self.newsData objectAtIndex:indexPath.row];
    
    details.url = news.url;
    
    //跳转后隐藏TabBar
    details.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:details animated:YES];
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
