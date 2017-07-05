//
//  SettingTopView.m
//  WETECHCushion
//
//  Created by iDev on 6/4/16.
//  Copyright © 2016 ___WETECH___. All rights reserved.
//

#import "SettingTopView.h"

#import "SettingTitleView.h"

@interface SettingTopView()

@property (nonatomic, strong)SettingTitleView *nicknameTitleView;
@property (nonatomic, strong)SettingTitleView *usernameTitleView;
@property (nonatomic, strong)SettingTitleView *sexTitleView;
@property (nonatomic, strong)SettingTitleView *ageTitleView;
@property (nonatomic, strong)SettingTitleView *modelsTitleView;

@property (nonatomic, strong)UILabel *nicknameLabel;
@property (nonatomic, strong)UILabel *usernameLabel;
@property (nonatomic, strong)UILabel *sexLabel;
@property (nonatomic, strong)UILabel *ageLabel;
@property (nonatomic, strong)UILabel *modelsLabel;

@end

@implementation SettingTopView

-(UIView*)nicknameTitleView{
    if(!_nicknameTitleView){
        _nicknameTitleView = [SettingTitleView new];
        _nicknameTitleView.backgroundColor = [UIColor clearColor];
        _nicknameTitleView.hidden = NO;
        _nicknameTitleView.titleImage = [UIImage imageNamed:@"nicknameImage"];
        _nicknameTitleView.titleLabelText = @"昵称";
    }
    return _nicknameTitleView;
}

-(UIView*)usernameTitleView{
    if(!_usernameTitleView){
        _usernameTitleView = [SettingTitleView new];
        _usernameTitleView.backgroundColor = [UIColor clearColor];
        _usernameTitleView.hidden = NO;
        _usernameTitleView.titleImage = [UIImage imageNamed:@"usernameImage"];
        _usernameTitleView.titleLabelText = @"用户名";
    }
    return _usernameTitleView;
}

-(UIView*)sexTitleView{
    if(!_sexTitleView){
        _sexTitleView = [SettingTitleView new];
        _sexTitleView.backgroundColor = [UIColor clearColor];
        _sexTitleView.hidden = NO;
        _sexTitleView.titleImage = [UIImage imageNamed:@"sexImage"];
        _sexTitleView.titleLabelText = @"性别";
    }
    return _sexTitleView;
}

-(UIView*)ageTitleView{
    if(!_ageTitleView){
        _ageTitleView = [SettingTitleView new];
        _ageTitleView.backgroundColor = [UIColor clearColor];
        _ageTitleView.hidden = NO;
        _ageTitleView.titleImage = [UIImage imageNamed:@"ageImage"];
        _ageTitleView.titleLabelText = @"年龄";
    }
    return _ageTitleView;
}

-(UIView*)modelsTitleView{
    if(!_modelsTitleView){
        _modelsTitleView = [SettingTitleView new];
        _modelsTitleView.backgroundColor = [UIColor clearColor];
        _modelsTitleView.hidden = NO;
        _modelsTitleView.titleImage = [UIImage imageNamed:@"modelsImage"];
        _modelsTitleView.titleLabelText = @"车型";
    }
    return _modelsTitleView;
}

-(UILabel*)nicknameLabel{
    if(!_nicknameLabel){
        _nicknameLabel = [UILabel new];
        _nicknameLabel.hidden = NO;
        _nicknameLabel.backgroundColor = [UIColor clearColor];
        _nicknameLabel.textColor = MAIN_BLUE_COLOR;
        _nicknameLabel.text = @"昵称";
        _nicknameLabel.font = [UIFont fontWithName:@"Heiti SC" size:17];
    }
    return _nicknameLabel;
}

-(UILabel*)usernameLabel{
    if(!_usernameLabel){
        _usernameLabel = [UILabel new];
        _usernameLabel.hidden = NO;
        _usernameLabel.backgroundColor = [UIColor clearColor];
        _usernameLabel.textColor = MAIN_BLUE_COLOR;
        _usernameLabel.text = @"用户名";
        _usernameLabel.font = [UIFont fontWithName:@"Heiti SC" size:17];
    }
    return _usernameLabel;
}

-(UILabel*)sexLabel{
    if(!_sexLabel){
        _sexLabel = [UILabel new];
        _sexLabel.hidden = NO;
        _sexLabel.backgroundColor = [UIColor clearColor];
        _sexLabel.textColor = MAIN_BLUE_COLOR;
        _sexLabel.text = @"未填写";
        _sexLabel.font = [UIFont fontWithName:@"Heiti SC" size:17];
    }
    return _sexLabel;
}

-(UILabel*)ageLabel{
    if(!_ageLabel){
        _ageLabel = [UILabel new];
        _ageLabel.hidden = NO;
        _ageLabel.backgroundColor = [UIColor clearColor];
        _ageLabel.textColor = MAIN_BLUE_COLOR;
        _ageLabel.text = @"未填写";
        _ageLabel.font = [UIFont fontWithName:@"Heiti SC" size:17];
    }
    return _ageLabel;
}

-(UILabel*)modelsLabel{
    if(!_modelsLabel){
        _modelsLabel = [UILabel new];
        _modelsLabel.hidden = NO;
        _modelsLabel.backgroundColor = [UIColor clearColor];
        _modelsLabel.textColor = MAIN_BLUE_COLOR;
        _modelsLabel.text = @"未填写";
        _modelsLabel.font = [UIFont fontWithName:@"Heiti SC" size:17];
    }
    return _modelsLabel;
}

-(void)addSubviewTree{
    [self addSubview:self.nicknameTitleView];
    [self addSubview:self.usernameTitleView];
    [self addSubview:self.sexTitleView];
    [self addSubview:self.ageTitleView];
    [self addSubview:self.modelsTitleView];
    
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.usernameLabel];
    [self addSubview:self.sexLabel];
    [self addSubview:self.ageLabel];
    [self addSubview:self.modelsLabel];
}

-(void)setViewsLayout{
    [_nicknameTitleView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.equalTo(self.left).offset(8);
        
        make.width.equalTo(self.mas_width).multipliedBy(0.37);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
    }];
    
    [_usernameTitleView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_nicknameTitleView.centerX);
        make.top.equalTo(_nicknameTitleView.mas_bottom).offset(4);
        
        make.width.equalTo(self.mas_width).multipliedBy(0.37);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
    }];
    
    [_sexTitleView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_nicknameTitleView.centerX);
        make.top.equalTo(_usernameTitleView.mas_bottom).offset(4);
        
        make.width.equalTo(self.mas_width).multipliedBy(0.37);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
    }];
    
    [_ageTitleView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_nicknameTitleView.centerX);
        make.top.equalTo(_sexTitleView.mas_bottom).offset(4);
        
        make.width.equalTo(self.mas_width).multipliedBy(0.37);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
    }];
    
    [_modelsTitleView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_nicknameTitleView.centerX);
        make.top.equalTo(_ageTitleView.mas_bottom).offset(4);
        
        make.width.equalTo(self.mas_width).multipliedBy(0.37);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
    }];
    
    [_nicknameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nicknameTitleView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-8);
        
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
    }];
    
    [_usernameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_usernameTitleView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-8);
        
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
    }];
    
    [_sexLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_sexTitleView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-8);
        
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
    }];
    
    [_ageLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_ageTitleView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-8);
        
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
    }];
    
    [_modelsLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_modelsTitleView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-8);
        
        make.height.equalTo(self.mas_height).multipliedBy(0.3);
    }];
}

-(void)initViews{
    [self setViewsLayout];
    
    [_nicknameTitleView simulateViewDidLoad];
    [_usernameTitleView simulateViewDidLoad];
    [_sexTitleView simulateViewDidLoad];
    [_ageTitleView simulateViewDidLoad];
    [_modelsTitleView simulateViewDidLoad];
}

- (void)simulateViewDidLoad
{
    [self addSubviewTree];
    [self initViews];
}

@end
