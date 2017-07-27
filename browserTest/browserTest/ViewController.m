//
//  ViewController.m
//  browserTest
//
//  Created by 朱育锋 on 17/7/15.
//  Copyright © 2017年 朱育锋. All rights reserved.
//

#import "ViewController.h"
#import "HistoryTableViewController.h"
#import "LikeTableViewController.h"

@interface ViewController ()<UIWebViewDelegate,UIGestureRecognizerDelegate>
{
    UIWebView * _webview;
    UITextField * _searchBar;
    BOOL _isUp;
    UILabel * _titlelabel;
    UISwipeGestureRecognizer * _upSwipe;
    UISwipeGestureRecognizer * _downSwipe;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _webview.scrollView.bounces=NO;
    _webview.delegate=self;
    _isUp = NO;
    _titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-40, 20)];
    _titlelabel.backgroundColor = [UIColor clearColor];
    _titlelabel.font = [UIFont systemFontOfSize:14];
    _titlelabel.textAlignment = NSTextAlignmentCenter;
    //默认加载百度
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.baidu.com"]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
    [self.view addSubview:_webview];
    //对导航栏进行设置
    [self creatSearchBar];
    //创建手势
    [self creatGesture];
    //创建工具栏
    [self creatToolbar];
}

- (void)creatSearchBar{
    _searchBar = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-40, 30)];
    _searchBar.borderStyle = UITextBorderStyleRoundedRect;
    UIButton * goBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [goBtn addTarget:self action:@selector(goWeb) forControlEvents:UIControlEventTouchUpInside];
    goBtn.frame=CGRectMake(0, 0, 30, 30);
    [goBtn setTitle:@"GO" forState:UIControlStateNormal];
    _searchBar.rightView = goBtn;
    _searchBar.rightViewMode = UITextFieldViewModeAlways;
    _searchBar.placeholder = @"请输入网址";
    self.navigationItem.titleView = _searchBar;
}

- (void)goWeb{
    if (_searchBar.text.length>0) {
        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",_searchBar.text]];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        [_webview loadRequest:request];
    }
    else{
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"输入的网页不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
}
//
- (void)creatGesture{
    _upSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(upSwipe)];
    _upSwipe.delegate = self;
    _upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [_webview addGestureRecognizer:_upSwipe];
    
    _downSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(downSwipe)];
    _downSwipe.delegate = self;
    _downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [_webview addGestureRecognizer:_downSwipe];
}

- (void)upSwipe{
    if (_isUp) {
        return;
    }
    self.navigationItem.titleView = nil;
    _webview.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-40);
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.navigationBar.frame = CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, 40);
        [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:7 forBarMetrics:UIBarMetricsDefault];
    }completion:^(BOOL finished){
        self.navigationItem.titleView = _titlelabel;
    }];
    [self.navigationController setToolbarHidden:YES animated:YES];
    _isUp = YES;
}

- (void)downSwipe{
    if (_webview.scrollView.contentOffset.y == 0&&_isUp) {
        self.navigationItem.titleView = nil;
        _webview.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
        [UIView animateWithDuration:0.3 animations:^{
            [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];
        }completion:^(BOOL finished){
            self.navigationItem.titleView = _searchBar;
        }];
        [self.navigationController setToolbarHidden:NO animated:YES];
        _isUp = NO;
    }
}

- (void)creatToolbar{
    self.navigationController.toolbarHidden = NO;
    UIBarButtonItem * itemHistory = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(goHistory)];
    UIBarButtonItem * itemlike = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(goLike)];
    UIBarButtonItem * itemBack = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    UIBarButtonItem * itemForward = [[UIBarButtonItem alloc]initWithTitle:@"forward" style:UIBarButtonItemStylePlain target:self action:@selector(goForward)];
    
    UIBarButtonItem * emptyItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * emptyItem2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * emptyItem3 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    self.toolbarItems = @[itemHistory,emptyItem,itemlike,emptyItem2,itemBack,emptyItem3,itemForward];
}

- (void)goHistory{
    HistoryTableViewController * controller = [[HistoryTableViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)goLike{
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选择您要进行的操作" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"添加收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        NSArray * array = [[NSUserDefaults standardUserDefaults]valueForKey:@"Like"];
        if (!array) {
            array = [[NSArray alloc]init];
        }
        NSMutableArray * newArray = [[NSMutableArray alloc]initWithArray:array];
        [newArray addObject:_webview.request.URL.absoluteString];
        [[NSUserDefaults standardUserDefaults]setValue:newArray forKey:@"Like"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"查看收藏夹" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            LikeTableViewController * controller = [[LikeTableViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }];
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [alert addAction:action2];
        [alert addAction:action3];
        [self presentViewController:alert animated:YES completion:nil];
}

- (void)goBack{
    if ([_webview canGoBack]) {
        [_webview goBack];
    }
}

- (void)goForward{
    if ([_webview canGoForward]) {
        [_webview goForward];
    }
}

- (void)loadURL:(NSString *)urlStr{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlStr]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    _titlelabel.text = webView.request.URL.absoluteString;
    NSArray * array = [[NSUserDefaults standardUserDefaults]valueForKey:@"History"];
    if (!array) {
        array = [[NSArray alloc]init];
    }
    NSMutableArray * newArray = [[NSMutableArray alloc]initWithArray:array];
    [newArray addObject:_titlelabel.text];
    [[NSUserDefaults standardUserDefaults]setValue:newArray forKey:@"History"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if (gestureRecognizer == _upSwipe||gestureRecognizer == _downSwipe) {
        return YES;
    }
    else{
        return NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
