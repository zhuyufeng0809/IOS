//
//  EditViewController.m
//  MailMe
//
//  Created by 朱育锋 on 17/7/5.
//  Copyright © 2017年 朱育锋. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "EditViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"

#import <Masonry.h>

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * menubutton = [UIButton buttonWithType:UIButtonTypeSystem];
    [menubutton setTitle:@"菜单" forState:UIControlStateNormal];
    menubutton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    [menubutton addTarget:self action:@selector(menu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: menubutton];

    UILabel * title = [[UILabel alloc]init];
    title.text = @"标题";
    title.font = [UIFont fontWithName:@"Helvetica" size:18];
    [self.view addSubview:title];
    
    UITextView * firstview = [[UITextView alloc]init];
    firstview.font = [UIFont fontWithName:@"Helvetica" size:25];
    firstview.textColor = [UIColor grayColor];
    firstview.text = @"无标题";
    [self.view addSubview:firstview];
    
    UILabel * content = [[UILabel alloc]init];
    content.text = @"内容";
    content.font = [UIFont fontWithName:@"Helvetica" size:18];
    [self.view addSubview:content];
    
    UITextView * secondview = [[UITextView alloc]init];
    secondview.font = [UIFont fontWithName:@"Helvetica" size:12];
    secondview.textColor = [UIColor grayColor];
    secondview.text = @"点击即可编辑";
    [self.view addSubview:secondview];
    
    UIButton * send = [UIButton buttonWithType:UIButtonTypeSystem];
    [send setTitle:@"发送" forState:UIControlStateNormal];
    send.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
    [self.view addSubview:send];
    
    UIImageView * plane = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"plane"]];
    [self.view addSubview:plane];
    
    [menubutton mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view.top).offset(30);
        make.right.equalTo(self.view.right).offset(-30);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@20);
        make.width.equalTo(@40);
        make.top.equalTo(self.view.top).offset(40);
        make.left.equalTo(self.view.left).offset(20);
    }];
    [firstview mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@50);
        make.width.equalTo(@300);
        make.centerX.equalTo(self.view);
        make.top.equalTo(title.bottom).offset(20);
        make.bottom.equalTo(content.top).offset(-20);
    }];
    [content mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@20);
        make.width.equalTo(@40);
        make.top.equalTo(firstview.bottom).offset(10);
        make.left.equalTo(self.view.left).offset(20);
    }];
    [secondview mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(@300);
        make.centerX.equalTo(self.view);
        make.top.equalTo(content.bottom).offset(20);
        make.bottom.equalTo(send.top).offset(-20);
    }];
    [send mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.bottom).offset(-80);
    }];
    [plane mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(42);
        make.width.equalTo(42);
        make.bottom.equalTo(self.view.bottom).offset(-85);
        make.right.equalTo(send.left).offset(-8);
    }];

}

- (void)menu{
    if (self.mm_drawerController != nil) {
        [self.mm_drawerController openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    }else{
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
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
