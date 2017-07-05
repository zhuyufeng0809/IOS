//
//  InsetViewController.m
//  MailMe
//
//  Created by 朱育锋 on 17/7/3.
//  Copyright © 2017年 朱育锋. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "InsetViewController.h"
#import "affirmViewController.h"
#import <Masonry.h>

@interface InsetViewController ()

@end

@implementation InsetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backButton setTitle:@"back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel * title = [[UILabel alloc]init];
    title.text = @"Mail Me";
    title.font = [UIFont fontWithName:@"Helvetica" size:35];
    [self.view addSubview:title];
    
    UILabel * sontitle = [[UILabel alloc]init];
    sontitle.text = @"您的邮箱地址";
    sontitle.font = [UIFont fontWithName:@"Helvetica" size:20];
    [self.view addSubview:sontitle];
    
    UIImageView * mail = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mail"]];
    [self.view addSubview:mail];
    
    UITextField * adress = [[UITextField alloc]init];
    adress.borderStyle = UITextBorderStyleRoundedRect;
    adress.text = @"email@example.com";
    adress.clearsOnBeginEditing = YES;
    adress.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:adress];
    
    UIImageView * yes = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yes"]];
    [self.view addSubview:yes];
    
    UIButton * affirmbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    [affirmbutton setTitle:@"确认" forState:UIControlStateNormal];
    affirmbutton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    [affirmbutton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:affirmbutton];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.top).offset(30);
        make.right.equalTo(self.view.right).offset(-30);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@60);
        make.width.equalTo(@150);
        make.left.equalTo(self.view.left).offset(15);
        make.top.equalTo(self.view.top).offset(50);
    }];
    [sontitle mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@30);
        make.width.equalTo(@150);
        make.left.equalTo(self.view.left).offset(30);
        make.top.equalTo(title.bottom).offset(40);
    }];
    [adress mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@20);
        make.width.equalTo(@200);
        make.centerX.equalTo(self.view);
        make.top.equalTo(sontitle.bottom).offset(20);
    }];
    [mail mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@25);
        make.width.equalTo(@30);
        make.right.equalTo(adress.left).offset(-8);
        make.top.equalTo(sontitle.bottom).offset(18);
    }];
    [affirmbutton mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@40);
        make.width.equalTo(@60);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.bottom).offset(-50);
    }];
    [yes mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@20);
        make.width.equalTo(@20);
        make.right.equalTo(affirmbutton.left).offset(10);
        make.bottom.equalTo(self.view.bottom).offset(-60);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)next{
    affirmViewController * con = [[affirmViewController alloc]init];
    [self presentViewController:con animated:YES completion:nil];
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
