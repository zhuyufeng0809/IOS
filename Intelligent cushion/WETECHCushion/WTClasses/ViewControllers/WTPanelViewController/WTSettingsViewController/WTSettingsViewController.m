//
//  WTSettingsViewController.m
//  WETECHCushion
//
//  Created by Will Hu on 5/7/16.
//  Copyright © 2016 ___WETECH___. All rights reserved.
//

#import "WTSettingsViewController.h"

#import "SettingTopView.h"
#import "SettingBottomView.h"
#import "SettingTitleView.h"

@interface WTSettingsViewController ()

@property (nonatomic, strong)SettingTopView *topView;
@property (nonatomic, strong)SettingBottomView *bottomView;

@end

@implementation WTSettingsViewController

-(SettingTopView*)topView{
    if(!_topView){
        _topView = [SettingTopView new];
        _topView.backgroundColor = [UIColor clearColor];
        _topView.hidden = NO;
    }
    return _topView;
}

-(SettingBottomView*)bottomView{
    if(!_bottomView){
        _bottomView = [SettingBottomView new];
        _bottomView.backgroundColor = [UIColor clearColor];
        _bottomView.hidden = NO;
    }
    return _bottomView;
}

-(void)addSubviewTree{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
}

-(void)setViewsLayout{
    [_topView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(7);
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.44);
    }];
    
    [_bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-34);
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.39);
    }];
}

-(void)initViews{
    [self setViewsLayout];
    [self initNavButton];
    
    [_topView simulateViewDidLoad];
    [_bottomView simulateViewDidLoad];
}

//自定义导航栏按钮
-(void)initNavButton{
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    settingBtn.frame = CGRectMake(0, 0, 30, 30);
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"settingImage"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn.layer setMasksToBounds:YES];
    [settingBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
    
    UIBarButtonItem *bitem = [[UIBarButtonItem alloc]initWithCustomView:settingBtn];
    self.navigationItem.rightBarButtonItem = bitem;
}

-(void)settingBtnAction{
    NSLog(@"settingBtnAction");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addSubviewTree];
    [self initViews];
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
