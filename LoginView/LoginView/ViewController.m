//
//  ViewController.m
//  LoginView
//
//  Created by 朱育锋 on 17/6/30.
//  Copyright © 2017年 朱育锋. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "ViewController.h"
#import "registerViewController.h"
#import <Masonry.h>

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //UILabel
    UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton * registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    UITextField * name = [[UITextField alloc]init];
    UITextField * password = [[UITextField alloc]init];

    name.borderStyle = UITextBorderStyleRoundedRect;
    password.borderStyle = UITextBorderStyleRoundedRect;
    name.text = @"请输入用户名";
    name.clearsOnBeginEditing = YES;
    name.clearButtonMode = UITextFieldViewModeWhileEditing;
    name.delegate = self;
    password.text = @"请输入密码";
    password.clearsOnBeginEditing = YES;
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.delegate = self;
    
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:name];
    [self.view addSubview:password];
    [self.view addSubview:loginButton];
    [self.view addSubview:registerButton];
    
    [name mas_makeConstraints:^(MASConstraintMaker *make){
        
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
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.height.equalTo(@30);
        make.width.equalTo(@40);
        make.left.equalTo(self.view.left).offset(65);
        make.top.equalTo(password.bottom).offset(100);
    }];
    
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.height.equalTo(@30);
        make.width.equalTo(@40);
        make.left.equalTo(self.view.left).offset(200);
        make.top.equalTo(password.bottom).offset(100);
    }];

}

- (void)skip{
    registerViewController * con = [[registerViewController alloc]init];
    [self presentViewController:con animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (void)touchesBegan:(NSSet< UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
