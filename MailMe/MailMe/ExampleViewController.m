//
//  ExampleViewController.m
//  MailMe
//
//  Created by 朱育锋 on 17/7/5.
//  Copyright © 2017年 朱育锋. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "ExampleViewController.h"
#import "EditViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "tableViewController.h"
#import <Masonry.h>

@interface ExampleViewController ()

@end

@implementation ExampleViewController

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
    title.text = @"标题";
    title.font = [UIFont fontWithName:@"Helvetica" size:18];
    [self.view addSubview:title];
    
    UITextView * firstview = [[UITextView alloc]init];
    firstview.text = @"欢迎使用MailMe！";
    firstview.editable = NO;
    firstview.font = [UIFont fontWithName:@"Helvetica" size:25];
    [self.view addSubview:firstview];
    
    UILabel * content = [[UILabel alloc]init];
    content.text = @"内容";
    content.font = [UIFont fontWithName:@"Helvetica" size:18];
    [self.view addSubview:content];
    
    UITextView * secondview = [[UITextView alloc]init];
    secondview.text = @"这是一封来自MailMe的实例邮件。您可以通过点击下面的“发送”按钮发送此邮件。MailMe可以让您轻易的将邮件发送给自己。再也无需打开完整的电子邮件程序并等待启动。只需打开MailMe，专注与您的内容，然后在瞬间进行发送。请查看我们的共享操作和通知中心窗口扩展，通过使用它们，您可以更快的将邮件发送给自己！衷心感谢您使用MailMe，我们希望您能喜欢上它。";
    secondview.font = [UIFont fontWithName:@"Helvetica" size:12];
    secondview.editable = NO;
    [self.view addSubview:secondview];
    
    UIButton * send = [UIButton buttonWithType:UIButtonTypeSystem];
    [send setTitle:@"发送" forState:UIControlStateNormal];
    send.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
    [send addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:send];
    
    UIImageView * plane = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"plane"]];
    [self.view addSubview:plane];
    
    [backbutton mas_makeConstraints:^(MASConstraintMaker *make){
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

- (void)next{
    EditViewController * mainview = [[EditViewController alloc]init];
    tableViewController * rightview = [[tableViewController alloc]init];
    MMDrawerController * con = [[MMDrawerController alloc]initWithCenterViewController:mainview rightDrawerViewController:rightview];
    con.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    con.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
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
