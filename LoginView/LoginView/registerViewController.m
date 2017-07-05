//
//  registerViewController.m
//  LoginView
//
//  Created by 朱育锋 on 17/7/1.
//  Copyright © 2017年 朱育锋. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "registerViewController.h"
#import <Masonry.h>

@interface registerViewController ()<UITextFieldDelegate>

@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField * name = [[UITextField alloc]init];
    UITextField * password = [[UITextField alloc]init];
    UITextField * passwordAgain = [[UITextField alloc]init];
    
    name.borderStyle = UITextBorderStyleRoundedRect;
    password.borderStyle = UITextBorderStyleRoundedRect;
    passwordAgain.borderStyle = UITextBorderStyleRoundedRect;
    
    name.text = @"请输入用户名";
    password.text =@"请输入密码";
    passwordAgain.text = @"再次输入密码";
    
    name.clearsOnBeginEditing = YES;
    password.clearsOnBeginEditing = YES;
    passwordAgain.clearsOnBeginEditing = YES;
    
    name.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordAgain.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIButton * registerbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton * backbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [registerbutton setTitle:@"注册" forState:UIControlStateNormal];
    [backbutton setTitle:@"返回登录" forState:UIControlStateNormal];
    
    [backbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:name];
    [self.view addSubview:password];
    [self.view addSubview:passwordAgain];
    [self.view addSubview:registerbutton];
    [self.view addSubview:backbutton];
    
    [name mas_makeConstraints:^(MASConstraintMaker * make){
        make.height.equalTo(@30);
        make.width.equalTo(@210);
        make.left.equalTo(self.view.left).offset(40);
        make.top.equalTo(self.view.top).offset(90);
    }];
    [password mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@30);
        make.width.equalTo(@210);
        make.left.equalTo(self.view.left).offset(40);
        make.top.equalTo(name.bottom).offset(30);
    }];
    [passwordAgain mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@30);
        make.width.equalTo(@210);
        make.left.equalTo(self.view.left).offset(40);
        make.top.equalTo(password.bottom).offset(30);
    }];
    [registerbutton mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@30);
        make.width.equalTo(@40);
        make.left.equalTo(self.view.left).offset(65);
        make.top.equalTo(passwordAgain.bottom).offset(100);
    }];
    [backbutton mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@30);
        make.width.equalTo(@60);
        make.left.equalTo(self.view.left).offset(200);
        make.top.equalTo(passwordAgain.bottom).offset(100);
    }];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField becomeFirstResponder];
    return [textField resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
