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

@property (nonatomic, strong)UITextField *nicknameTextField;
@property (nonatomic, strong)UITextField *usernameTextField;
@property (nonatomic, strong)UITextField *sexTextField;
@property (nonatomic, strong)UITextField *ageTextField;
@property (nonatomic, strong)UITextField *modelsTextField;

@property (nonatomic, strong)NSString *userNickname;
@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong)NSString *userSex;
@property (nonatomic, strong)NSString *userAge;
@property (nonatomic, strong)NSString *userModels;

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
        _sexTitleView.isSexImage = YES;
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

-(UITextField*)nicknameTextField{
    if(!_nicknameTextField){
        _nicknameTextField = [UITextField new];
        _nicknameTextField.hidden = NO;
        _nicknameTextField.backgroundColor = [UIColor clearColor];
        _nicknameTextField.textColor = MAIN_BLUE_COLOR;
        _nicknameTextField.text = _userNickname;
        _nicknameTextField.font = [UIFont fontWithName:@"Heiti SC" size:19];
        _nicknameTextField.textAlignment = NSTextAlignmentRight;
        _nicknameTextField.delegate = self;
        _nicknameTextField.returnKeyType = UIReturnKeyDone;
        _nicknameTextField.adjustsFontSizeToFitWidth = YES;
        _nicknameTextField.tag = 0;
        [_nicknameTextField addTarget:self action:@selector(textFieldValueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    }
    return _nicknameTextField;
}

-(UITextField*)usernameTextField{
    if(!_usernameTextField){
        _usernameTextField = [UITextField new];
        _usernameTextField.hidden = NO;
        _usernameTextField.backgroundColor = [UIColor clearColor];
        _usernameTextField.textColor = MAIN_BLUE_COLOR;
        _usernameTextField.text = _userName;
        _usernameTextField.font = [UIFont fontWithName:@"Heiti SC" size:19];
        _usernameTextField.textAlignment = NSTextAlignmentRight;
        _usernameTextField.delegate = self;
        _usernameTextField.returnKeyType = UIReturnKeyDone;
        _usernameTextField.adjustsFontSizeToFitWidth = YES;
        _usernameTextField.tag = 1;
        [_usernameTextField addTarget:self action:@selector(textFieldValueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    }
    return _usernameTextField;
}

-(UITextField*)sexTextField{
    if(!_sexTextField){
        _sexTextField = [UITextField new];
        _sexTextField.hidden = NO;
        _sexTextField.backgroundColor = [UIColor clearColor];
        _sexTextField.textColor = MAIN_BLUE_COLOR;
        _sexTextField.text = _userSex;
        _sexTextField.font = [UIFont fontWithName:@"Heiti SC" size:19];
        _sexTextField.textAlignment = NSTextAlignmentRight;
        _sexTextField.delegate = self;
        _sexTextField.returnKeyType = UIReturnKeyDone;
        _sexTextField.adjustsFontSizeToFitWidth = YES;
        _sexTextField.tag = 2;
        [_sexTextField addTarget:self action:@selector(textFieldValueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    }
    return _sexTextField;
}

-(UITextField*)ageTextField{
    if(!_ageTextField){
        _ageTextField = [UITextField new];
        _ageTextField.hidden = NO;
        _ageTextField.backgroundColor = [UIColor clearColor];
        _ageTextField.textColor = MAIN_BLUE_COLOR;
        _ageTextField.text = _userAge;
        _ageTextField.font = [UIFont fontWithName:@"Heiti SC" size:19];
        _ageTextField.textAlignment = NSTextAlignmentRight;
        _ageTextField.delegate = self;
        _ageTextField.returnKeyType = UIReturnKeyDone;
        _ageTextField.adjustsFontSizeToFitWidth = YES;
        _ageTextField.tag = 3;
        [_ageTextField addTarget:self action:@selector(textFieldValueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    }
    return _ageTextField;
}

-(UITextField*)modelsTextField{
    if(!_modelsTextField){
        _modelsTextField = [UITextField new];
        _modelsTextField.hidden = NO;
        _modelsTextField.backgroundColor = [UIColor clearColor];
        _modelsTextField.textColor = MAIN_BLUE_COLOR;
        _modelsTextField.text = _userModels;
        _modelsTextField.font = [UIFont fontWithName:@"Heiti SC" size:19];
        
        _modelsTitleView.isThickLine = YES;
        
        _modelsTextField.textAlignment = NSTextAlignmentRight;
        _modelsTextField.delegate = self;
        _modelsTextField.returnKeyType = UIReturnKeyDone;
        _modelsTextField.adjustsFontSizeToFitWidth = YES;
        _modelsTextField.tag = 4;
        [_modelsTextField addTarget:self action:@selector(textFieldValueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    }
    return _modelsTextField;
}

-(void)addSubviewTree{
    [self addSubview:self.nicknameTitleView];
    [self addSubview:self.usernameTitleView];
    [self addSubview:self.sexTitleView];
    [self addSubview:self.ageTitleView];
    [self addSubview:self.modelsTitleView];
    
    [self addSubview:self.nicknameTextField];
    [self addSubview:self.usernameTextField];
    [self addSubview:self.sexTextField];
    [self addSubview:self.ageTextField];
    [self addSubview:self.modelsTextField];
}

-(void)setViewsLayout{
    [_nicknameTitleView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.equalTo(self.left).offset(10);
        
        make.width.equalTo(self.mas_width).multipliedBy(0.37);
        make.height.equalTo(@(SCREEN_HEIGHT / 13));
    }];
    
    [_usernameTitleView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_nicknameTitleView.centerX);
        make.top.equalTo(_nicknameTitleView.mas_bottom);
        
        make.width.equalTo(self.mas_width).multipliedBy(0.37);
        make.height.equalTo(@(SCREEN_HEIGHT / 13));
    }];
    
    [_sexTitleView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_nicknameTitleView.centerX);
        make.top.equalTo(_usernameTitleView.mas_bottom);
        
        make.width.equalTo(self.mas_width).multipliedBy(0.37);
        make.height.equalTo(@(SCREEN_HEIGHT / 13));
    }];
    
    [_ageTitleView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_nicknameTitleView.centerX);
        make.top.equalTo(_sexTitleView.mas_bottom);
        
        make.width.equalTo(self.mas_width).multipliedBy(0.37);
        make.height.equalTo(@(SCREEN_HEIGHT / 13));
    }];
    
    [_modelsTitleView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_nicknameTitleView.centerX);
        make.top.equalTo(_ageTitleView.mas_bottom);
        
        make.width.equalTo(self.mas_width).multipliedBy(0.37);
        make.height.equalTo(@(SCREEN_HEIGHT / 13));
    }];
    
    
    
    
    [_nicknameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nicknameTitleView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-18);
        
        make.height.equalTo(@(SCREEN_HEIGHT / 13));
    }];
    
    [_usernameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_usernameTitleView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-18);
        
        make.height.equalTo(@(SCREEN_HEIGHT / 13));
    }];
    
    [_sexTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_sexTitleView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-18);
        
        make.height.equalTo(@(SCREEN_HEIGHT / 13));
    }];
    
    [_ageTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_ageTitleView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-18);
        
        make.height.equalTo(@(SCREEN_HEIGHT / 13));
    }];
    
    [_modelsTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_modelsTitleView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-18);
        
        make.height.equalTo(@(SCREEN_HEIGHT / 13));
    }];
}

-(void)getUserInformation{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    if(userDef){
        _userNickname = [userDef objectForKey:@"userNickname"];
        _userName = [userDef objectForKey:@"userName"];
        _userSex = [userDef objectForKey:@"userSex"];
        _userAge = [userDef objectForKey:@"userAge"];
        _userModels = [userDef objectForKey:@"userModels"];
    }else{
        _userNickname = @"未填写";
        _userName = @"未填写";
        _userSex = @"未填写";
        _userAge = @"未填写";
        _userModels = @"未填写";
    }
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
    [self getUserInformation];
    [self addSubviewTree];
    [self initViews];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];    //[receiver resignFirstResponder]把receiver对应的键盘下收
    return YES;
}

-(void)textFieldValueChanged:(UITextField*)textField{
    NSArray *arrTextFieldType = @[@"userNickname", @"userName", @"userSex", @"userAge", @"userModels"];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:textField.text forKey:[arrTextFieldType objectAtIndex:textField.tag]];
}

@end
