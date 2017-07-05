//
//  ViewController.m
//  MailMe
//
//  Created by 朱育锋 on 17/7/3.
//  Copyright © 2017年 朱育锋. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "ViewController.h"
#import "InsetViewController.h"
#import <Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView * snake = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"snake"]];
    
    UILabel * title = [[UILabel alloc]init];
    title.text = @"Mail Me";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:@"Helvetica" size:28];
    
    UILabel * intro = [[UILabel alloc]init];
    intro.text = @"发送邮件给自己无论何时，无论何地";
    intro.numberOfLines = 2;
    intro.font = [UIFont fontWithName:@"Helvetica" size:15];
    
    UIButton * start = [UIButton buttonWithType:UIButtonTypeSystem];
    [start setTitle:@"开始" forState:UIControlStateNormal];
    start.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    [start addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * mail = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mail"]];
    
    [self.view addSubview:snake];
    [self.view addSubview:mail];
    [self.view addSubview:title];
    [self.view addSubview:intro];
    [self.view addSubview:start];
    
    [snake mas_makeConstraints:^(MASConstraintMaker * make){
        make.height.equalTo(@250);
        make.width.equalTo(@250);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.top).offset(20);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@20);
        make.width.equalTo(@100);
        make.centerX.equalTo(self.view);
        make.top.equalTo(snake.bottom).offset(10);
    }];
    [intro mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@60);
        make.width.equalTo(@150);
        make.centerX.equalTo(self.view);
        make.top.equalTo(title.bottom).offset(10);
    }];
    [start mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@40);
        make.width.equalTo(@60);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.bottom).offset(-60);
    }];
    [mail mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@25);
        make.width.equalTo(@25);
        make.bottom.equalTo(self.view.bottom).offset(-67);
        make.right.equalTo(start.left).offset(0);
    }];
}

- (void)next{
    InsetViewController * con = [[InsetViewController alloc]init];
    [self presentViewController:con animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
