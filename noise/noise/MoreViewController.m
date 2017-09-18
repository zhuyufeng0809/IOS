//
//  MoreViewController.m
//  noiseTest
//
//  Created by 朱育锋 on 17/7/24.
//  Copyright © 2017年 朱育锋. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/4 , 100, 40)];
    nameLabel.text = @"关于作者";
    //nameLabel.backgroundColor = [UIColor greenColor];
    nameLabel.font = [UIFont systemFontOfSize:25];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameLabel];
    
    UILabel * askLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-75, self.view.frame.size.height/3, 150, 100)];
    askLabel.text = @"在使用过程中如有任何问题，请联系Email:1547107965@qq.com";
    askLabel.textAlignment = NSTextAlignmentCenter;
    askLabel.font = [UIFont systemFontOfSize:15];
    //askLabel.backgroundColor = [UIColor greenColor];
    askLabel.numberOfLines = 3;
    [self.view addSubview:askLabel];
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
