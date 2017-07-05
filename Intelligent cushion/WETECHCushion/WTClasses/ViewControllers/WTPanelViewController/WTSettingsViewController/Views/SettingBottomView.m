//
//  SettingBottomView.m
//  WETECHCushion
//
//  Created by iDev on 6/4/16.
//  Copyright © 2016 ___WETECH___. All rights reserved.
//

#import "SettingBottomView.h"
#import "SettingTitleView.h"

@interface SettingBottomView()

@property (nonatomic, strong)SettingTitleView *scanTitleView;
@property (nonatomic, strong)UIButton *scanButton;

@property (nonatomic, strong)SettingTitleView *aboutTitleView;
@property (nonatomic, strong)UIButton *aboutButton;

@property (nonatomic, strong)UIButton *logoutButton;

@end

@implementation SettingBottomView

-(SettingTitleView*)scanTitleView{
    if(!_scanTitleView){
        _scanTitleView = [SettingTitleView new];
        _scanTitleView.backgroundColor = [UIColor clearColor];
        _scanTitleView.hidden = NO;
        _scanTitleView.titleImage = [UIImage imageNamed:@"scanImage"];
        _scanTitleView.titleLabelText = @"扫一扫";
        _scanTitleView.titleLabel.textColor = MAIN_BLUE_COLOR;
        _scanTitleView.titleLabelFont = [UIFont fontWithName:@"HelveticalNeue-Bold" size:20];
    }
    return _scanTitleView;
}

-(UIButton*)scanButton{
    if(!_scanButton){
        _scanButton = [UIButton new];
        _scanButton.backgroundColor = [UIColor clearColor];
        _scanButton.hidden = NO;
        [_scanButton addTarget:self action:@selector(scanButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanButton;
}

-(SettingTitleView*)aboutTitleView{
    if(!_aboutTitleView){
        _aboutTitleView = [SettingTitleView new];
        _aboutTitleView.backgroundColor = [UIColor clearColor];
        _aboutTitleView.hidden = NO;
        _aboutTitleView.titleImage = [UIImage imageNamed:@"aboutImage"];
        _aboutTitleView.titleLabelText = @"关于";
        _aboutTitleView.titleLabel.textColor = MAIN_BLUE_COLOR;
        _aboutTitleView.titleLabelFont = [UIFont fontWithName:@"HelveticalNeue-Bold" size:20];
        _aboutTitleView.isThickLine = YES;
    }
    return _aboutTitleView;
}

-(UIButton*)aboutButton{
    if(!_aboutButton){
        _aboutButton = [UIButton new];
        _aboutButton.backgroundColor = [UIColor clearColor];
        _aboutButton.hidden = NO;
        [_aboutButton addTarget:self action:@selector(aboutButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aboutButton;
}

-(UIButton*)logoutButton{
    if(!_logoutButton){
        _logoutButton = [UIButton new];
        _logoutButton.backgroundColor = [UIColor clearColor];
        _logoutButton.hidden = NO;
        [_logoutButton setBackgroundImage:[UIImage imageNamed:@"logoutImage"] forState:UIControlStateNormal];
        //titleLabel
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _logoutButton.titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:16];
        _logoutButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        [_logoutButton addTarget:self action:@selector(logoutButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}

-(void)scanButtonAction{
    NSLog(@"scanButtonAction");
}

-(void)aboutButtonAction{
    NSLog(@"aboutButtonAction");
}

-(void)logoutButtonAction{
    NSLog(@"logoutButtonAction");
}

-(void)addSubviewTree{
    [self addSubview:[self scanTitleView]];
    [self addSubview:[self scanButton]];
    [self addSubview:[self aboutTitleView]];
    [self addSubview:[self aboutButton]];
    [self addSubview:[self logoutButton]];
}

-(void)setViewsLayout{
    [_scanTitleView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top);
        
        make.width.equalTo(self.mas_width).multipliedBy(0.37);
        make.height.equalTo(@(SCREEN_HEIGHT / 13));
    }];
    
    [_scanButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.centerY.equalTo(_scanTitleView.centerY);
        
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@(SCREEN_HEIGHT / 13));
    }];
    
    [_aboutTitleView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scanTitleView.mas_centerX);
        make.top.equalTo(_scanTitleView.bottom);
        
        make.width.equalTo(self.mas_width).multipliedBy(0.37);
        make.height.equalTo(@(SCREEN_HEIGHT / 13));
    }];
    
    [_aboutButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.centerY.equalTo(_aboutTitleView.centerY);
        
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@(SCREEN_HEIGHT / 13));
    }];
    
    [_logoutButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(_aboutButton.bottom).offset(18.5);
        
        make.width.equalTo(self.mas_width).multipliedBy(0.88);
        make.height.equalTo(self.mas_height).multipliedBy(0.29);
    }];
}

-(void)initViews{
    [self setViewsLayout];
    
    [_scanTitleView simulateViewDidLoad];
    [_aboutTitleView simulateViewDidLoad];
}

-(void)simulateViewDidLoad{
    [self addSubviewTree];
    [self initViews];
}

@end
