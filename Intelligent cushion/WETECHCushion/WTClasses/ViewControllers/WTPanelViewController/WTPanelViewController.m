//
//  WTPanelViewController.m
//  WETECHCushion
//
//  Created by Will Hu on 5/7/16.
//  Copyright © 2016 ___WETECH___. All rights reserved.
//

#import "WTPanelViewController.h"

#import "PanelTopView.h"
#import "PanelMiddleView.h"
#import "PanelBottomView.h"

#define MAS_SHORTHAND
#import "Masonry.h"

@interface WTPanelViewController ()

@property (nonatomic, strong)PanelTopView *topView;
@property (nonatomic, strong)PanelMiddleView *middleView;
@property (nonatomic, strong)PanelBottomView *bottomView;

@end

@implementation WTPanelViewController

#pragma mark - Private properties

- (PanelTopView*)topView
{
    if (!_topView) {
        _topView = [PanelTopView new];
        _topView.backgroundColor = [UIColor clearColor];
        _topView.hidden = NO;
        _topView.timeLabelText = [self getDate];
    }
    return _topView;
}

- (PanelMiddleView*)middleView
{
    if (!_middleView) {
        _middleView = [PanelMiddleView new];
        _middleView.backgroundColor = [UIColor clearColor];
        _middleView.hidden = NO;
    }
    return _middleView;
}

- (PanelBottomView*)bottomView
{
    if (!_bottomView) {
        _bottomView = [PanelBottomView new];
        _bottomView.backgroundColor = [UIColor clearColor];
        _bottomView.hidden = NO;
    }
    return _bottomView;
}

#pragma mark - View lifecycle

- (void)addSubviewTree
{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.middleView];
    [self.view addSubview:self.bottomView];
    self.topView.backgroundColor = MAIN_BLUE_COLOR;
    self.middleView.backgroundColor = [UIColor whiteColor];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    self.bottomView.middleView = self.middleView;
}

- (void)setViewsLayout
{
    [self.topView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(0);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        
        make.height.equalTo(@(90));
    }];
    
    [self.middleView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.bottom);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        
        make.height.equalTo(@(120));
    }];
    
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView.bottom);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        
        make.bottom.equalTo(self.view.bottom);
    }];
    
}

//获取日期
-(NSString*)getDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday ;
    //NSDateComponents *dateComponent = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:now];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    int month = [dateComponents month];
    int day = [dateComponents day];
    int weekday = [dateComponents weekday];
    NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五", @"周六", nil];
    NSString *timeLabelText = [NSString stringWithFormat:@"%@ %d/%d", [arrWeek objectAtIndex:(weekday - 1)], day, month];
    return timeLabelText;
}

- (void)initViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setViewsLayout];
    [self.topView simulateViewDidLoad];
    [self.middleView simulateViewDidLoad];
    [self.bottomView simulateViewDidLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSubviewTree];
    [self initViews];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
