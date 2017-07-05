//
//  affirmViewController.m
//  MailMe
//
//  Created by 朱育锋 on 17/7/4.
//  Copyright © 2017年 朱育锋. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "affirmViewController.h"
#import "PasswordViewController.h"
#import <Masonry.h>

@interface affirmViewController ()

@end

@implementation affirmViewController

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
    firstsontitle.text = @"确认邮件已发送";
    firstsontitle.font = [UIFont fontWithName:@"Helvetica" size:25];
    [self.view addSubview:firstsontitle];
    
    UILabel * secondtitle = [[UILabel alloc]init];
    secondtitle.text = @"请点击邮件中的链接，或者输入验证码";
    secondtitle.font = [UIFont fontWithName:@"Helvetica" size:15];
    secondtitle.numberOfLines = 2;
    [self.view addSubview:secondtitle];
    
    UIImageView * pen = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pen"]];
    [self.view addSubview:pen];
    
    UIButton * nextbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextbutton setTitle:@"输入验证码" forState:UIControlStateNormal];
    nextbutton.titleLabel.font = [UIFont fontWithName:@"helvetica" size:20];
    [nextbutton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextbutton];
    
    UILabel * alert = [[UILabel alloc]init];
    alert.text = @"没有收到？请检查您的垃圾邮箱或将mail.mailmeapp.com加入白名单";
    alert.font = [UIFont fontWithName:@"helvetica" size:10];
    alert.numberOfLines = 2;
    [self.view addSubview:alert];
    
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
        make.height.equalTo(@40);
        make.width.equalTo(@180);
        make.centerX.equalTo(self.view);
        make.top.equalTo(title.bottom).offset(60);
    }];
    [secondtitle mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@150);
        make.height.equalTo(@50);
        make.centerX.equalTo(self.view);
        make.top.equalTo(firstsontitle.bottom).offset(10);
    }];
    [nextbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.bottom).offset(-80);
    }];
    [pen mas_makeConstraints:^(MASConstraintMaker * make){
        make.height.equalTo(22);
        make.width.equalTo(22);
        make.bottom.equalTo(self.view.bottom).offset(-85);
        make.right.equalTo(nextbutton.left).offset(-8);
    }];
    [alert mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@40);
        make.width.equalTo(@160);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.bottom).offset(-20);
    }];
}

- (void)next{
    PasswordViewController * con = [[PasswordViewController alloc]init];
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
