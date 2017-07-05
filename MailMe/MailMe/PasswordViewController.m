//
//  PasswordViewController.m
//  MailMe
//
//  Created by 朱育锋 on 17/7/4.
//  Copyright © 2017年 朱育锋. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "PasswordViewController.h"
#import "ExampleViewController.h"
#import <Masonry.h>

@interface PasswordViewController ()

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * backbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backbutton setTitle:@"Back" forState:UIControlStateNormal];
    backbutton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    [backbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: backbutton];
    
    UILabel * title = [[UILabel alloc]init];
    title.text = @"验证邮件";
    title.font = [UIFont fontWithName:@"Helvetica" size:35];
    [self.view addSubview:title];
    
    UILabel * firstsontitle = [[UILabel alloc]init];
    firstsontitle.text = @"验证码";
    firstsontitle.font = [UIFont fontWithName:@"Helvetica" size:25];
    [self.view addSubview:firstsontitle];
    
    UITextField * password = [[UITextField alloc]init];
    password.text = @"验证码";
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    password.clearsOnBeginEditing =YES;
    [self.view addSubview:password];
    
    UIButton * affirmbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    [affirmbutton setTitle:@"确认" forState:UIControlStateNormal];
    affirmbutton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    [affirmbutton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:affirmbutton];
    
    UIImageView * yes = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yes"]];
    [self.view addSubview:yes];
    
    [backbutton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.top).offset(30);
        make.right.equalTo(self.view.right).offset(-30);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@80);
        make.width.equalTo(@150);
        make.top.equalTo(self.view.top).offset(50);
        make.left.equalTo(self.view.left).offset(20);
    }];
    [firstsontitle mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@30);
        make.width.equalTo(@150);
        make.left.equalTo(self.view.left).offset(30);
        make.top.equalTo(title.bottom).offset(40);
    }];
    [password mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@20);
        make.width.equalTo(@200);
        make.centerX.equalTo(self.view);
        make.top.equalTo(firstsontitle.bottom).offset(20);
    }];
    [affirmbutton mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.bottom).offset(-80);
    }];
    [yes mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(22);
        make.width.equalTo(22);
        make.bottom.equalTo(self.view.bottom).offset(-85);
        make.right.equalTo(affirmbutton.left).offset(-8);
    }];
}

-(void)next{
    ExampleViewController * con = [[ExampleViewController alloc]init];
    [self presentViewController:con animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
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
