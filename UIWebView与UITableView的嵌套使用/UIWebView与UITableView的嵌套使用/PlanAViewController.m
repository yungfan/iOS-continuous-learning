//
//  PlanAViewController.m
//  ScrollViewNestDemo
//
//  Created by XuNing on 2017/11/12.
//  Copyright © 2017年 xuning. All rights reserved.
//

#import "PlanAViewController.h"
#import "CommentTableViewController.h"

@interface PlanAViewController () <UIWebViewDelegate>
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) CommentTableViewController *commentTableViewController;
@end

@implementation PlanAViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.commentTableViewController];
    [self.view addSubview:self.commentTableViewController.view];
    [self.commentTableViewController didMoveToParentViewController:self];
    
    self.commentTableViewController.tableView.tableHeaderView = self.webView;
    
    //  NSString *htmlString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
    //  [self.webView loadHTMLString:htmlString baseURL:nil];
    
    NSURLRequest *requet = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.abc.edu.cn"]];
    
    [self.webView loadRequest:requet];
}

- (void)dealloc {
    [_webView loadHTMLString:@"" baseURL:nil];
    [_webView stopLoading];
    _webView.delegate = nil;
    [_webView removeFromSuperview];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGFloat contentHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"].floatValue;
    CGRect frame = webView.frame;
    frame.size.height = contentHeight;
    webView.frame = frame;
    self.commentTableViewController.tableView.tableHeaderView = webView;
}

#pragma mark - Getters
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.scrollView.scrollEnabled = NO;
        _webView.delegate = self;
    }
    return _webView;
}

- (CommentTableViewController *)commentTableViewController {
    if (!_commentTableViewController) {
        _commentTableViewController = [[CommentTableViewController alloc] initWithStyle:UITableViewStylePlain];
    }
    return _commentTableViewController;
}

@end
