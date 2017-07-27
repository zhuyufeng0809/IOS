//
//  WaveformTableViewController.m
//  noiseTest
//
//  Created by 朱育锋 on 17/7/24.
//  Copyright © 2017年 朱育锋. All rights reserved.
//

#import "WaveformTableViewController.h"

@interface WaveformTableViewController ()
{
    NSArray * _dataArray;
}
@end

@implementation WaveformTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor greenColor];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.rowHeight = 100;
    //self.tableView.scrollsToTop = YES;
    // self.tableView.scrollEnabled = YES;
    //self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100*12);
    NSString * str0 = [NSString stringWithFormat:@"0dB  人类能听到的最小声音"];
    NSString * str1 = [NSString stringWithFormat:@"10dB 呼吸声很难听到"];
    NSString * str2 = [NSString stringWithFormat:@"20dB 耳语，微风吹动树叶"];
    NSString * str3 = [NSString stringWithFormat:@"30dB 安静的农村地区"];
    NSString * str4 = [NSString stringWithFormat:@"40dB 图书馆，城市环境最低声音"];
    NSString * str5 = [NSString stringWithFormat:@"50dB 安静的近邻，在家里谈话"];
    NSString * str6 = [NSString stringWithFormat:@"60dB 餐厅，办公室的对话"];
    NSString * str7 = [NSString stringWithFormat:@"70dB 小汽车，吸尘器，广播"];
    NSString * str8 = [NSString stringWithFormat:@"80dB 垃圾处理厂，柴油卡车"];
    NSString * str9 = [NSString stringWithFormat:@"90dB 播音737一公里外着陆"];
    NSString * str10 = [NSString stringWithFormat:@"100dB 拖拉机"];
    NSString * str11 = [NSString stringWithFormat:@"110dB 钢铁厂"];
    
    _dataArray = [NSArray arrayWithObjects:str0,str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11, nil];
    NSLog(@"%@",_dataArray[2]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 12;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    // Configure the cell...
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
