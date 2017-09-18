//
//  ViewController.m
//  noise
//
//  Created by 朱育锋 on 17/8/5.
//  Copyright © 2017年 朱育锋. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImageView * solutionview;
    UIImageView * Thermometer;
    KKNoiseRecognizer *recognizer;
}

@property UILabel * curlabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    recognizer = [KKNoiseRecognizer recognizer];
    recognizer.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*0.6, self.view.frame.size.height)];
    leftview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:leftview];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(self.view.frame.size.width*0.75, self.view.frame.size.height*0.8, 25, 25);
    [self.view addSubview:btn];
    
    UILabel * current = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.68, self.view.frame.size.height*0.5, 80, 50)];
    current.font = [UIFont systemFontOfSize:13];
    current.textColor = [UIColor grayColor];
    current.text = @"当前数值(dB)";
    [self.view addSubview:current];
    
    //////////////////////
    
    
    //
    Thermometer = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"温度计"]];
    Thermometer.frame = CGRectMake(self.view.frame.size.width*0.15, self.view.frame.size.height*0.1, 40, 450);
    [self.view addSubview:Thermometer];
    //
    UIImageView * scale = [[UIImageView alloc]initWithFrame:CGRectMake(0, 37.5, Thermometer.frame.size.width, 412.5)];
    UIImage * kedu = [UIImage imageNamed:@"刻度"];
    kedu = [kedu resizableImageWithCapInsets:UIEdgeInsetsZero];
    [scale setImage:kedu];
    [Thermometer addSubview:scale];
    //
    solutionview = [[UIImageView alloc]init];
    [Thermometer addSubview:solutionview];
    
    
    UIImage * solution = [UIImage imageNamed:@"溶液"];
    UIEdgeInsets insets = UIEdgeInsetsMake(200, 0, 250, 0);
    [solution resizableImageWithCapInsets:insets];
    
    [solutionview setImage:solution];
    //
    UILabel * detail0 = [[UILabel alloc]initWithFrame:CGRectMake(100, 93, 70, 10)];
    detail0.text = @"110dB 很危险";
    detail0.textColor = [UIColor whiteColor];
    detail0.font = [UIFont systemFontOfSize:11];
    [leftview addSubview:detail0];
    
    UILabel * detail1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 127, 70, 10)];
    detail1.text = @"100dB 危险";
    detail1.textColor = [UIColor whiteColor];
    detail1.font = [UIFont systemFontOfSize:11];
    [leftview addSubview:detail1];
    
    UILabel * detail2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 163, 80, 10)];
    detail2.text = @"90dB 可能有害";
    detail2.textColor = [UIColor whiteColor];
    detail2.font = [UIFont systemFontOfSize:11];
    [leftview addSubview:detail2];
    
    UILabel * detail3 = [[UILabel alloc]initWithFrame:CGRectMake(100, 199, 80, 10)];
    detail3.text = @"80dB 潜在危害";
    detail3.textColor = [UIColor whiteColor];
    detail3.font = [UIFont systemFontOfSize:11];
    [leftview addSubview:detail3];
    
    UILabel * detail4 = [[UILabel alloc]initWithFrame:CGRectMake(100, 238, 80, 10)];
    detail4.text = @"70dB 扰人";
    detail4.textColor = [UIColor whiteColor];
    detail4.font = [UIFont systemFontOfSize:11];
    [leftview addSubview:detail4];
    
    UILabel * detail5 = [[UILabel alloc]initWithFrame:CGRectMake(100, 275, 80, 10)];
    detail5.text = @"60dB 大声谈话";
    detail5.textColor = [UIColor whiteColor];
    detail5.font = [UIFont systemFontOfSize:11];
    [leftview addSubview:detail5];
    
    UILabel * detail6 = [[UILabel alloc]initWithFrame:CGRectMake(100, 311, 80, 10)];
    detail6.text = @"50dB 普通谈话";
    detail6.textColor = [UIColor whiteColor];
    detail6.font = [UIFont systemFontOfSize:11];
    [leftview addSubview:detail6];
    
    UILabel * detail7 = [[UILabel alloc]initWithFrame:CGRectMake(100, 348, 80, 10)];
    detail7.text = @"40dB 小声谈话";
    detail7.textColor = [UIColor whiteColor];
    detail7.font = [UIFont systemFontOfSize:11];
    [leftview addSubview:detail7];
    
    UILabel * detail8 = [[UILabel alloc]initWithFrame:CGRectMake(100, 386, 70, 10)];
    detail8.text = @"30dB 耳语";
    detail8.textColor = [UIColor whiteColor];
    detail8.font = [UIFont systemFontOfSize:11];
    [leftview addSubview:detail8];
    
    UILabel * detail9 = [[UILabel alloc]initWithFrame:CGRectMake(100, 424, 70, 10)];
    detail9.text = @"20dB 安静";
    detail9.textColor = [UIColor whiteColor];
    detail9.font = [UIFont systemFontOfSize:11];
    [leftview addSubview:detail9];
    
    UILabel * detail10 = [[UILabel alloc]initWithFrame:CGRectMake(100, 462, 70, 10)];
    detail10.text = @"10dB 听不见";
    detail10.textColor = [UIColor whiteColor];
    detail10.font = [UIFont systemFontOfSize:11];
    [leftview addSubview:detail10];

    
    self.curlabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.65, self.view.frame.size.height*0.58, 110, 80)];
    self.curlabel.text = @"0";
    self.curlabel.textAlignment = NSTextAlignmentCenter;
    self.curlabel.font = [UIFont fontWithName:@"Avenir Next" size:40];
    self.curlabel.textColor = [UIColor blackColor];
    [self.view addSubview:self.curlabel];
    
    UIButton * start = [UIButton buttonWithType:UIButtonTypeSystem];
    [start setTitle:@"开始" forState:UIControlStateNormal];
    start.frame =CGRectMake(self.view.frame.size.width/5*3 , self.view.frame.size.height/5, 100, 40);
    start.font = [UIFont systemFontOfSize:20];
    start.tintColor = [UIColor blackColor];
    [start addTarget:self action:@selector(startrecord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
    
    UIButton * stop = [UIButton buttonWithType:UIButtonTypeSystem];
    [stop setTitle:@"停止" forState:UIControlStateNormal];
    stop.frame = CGRectMake(self.view.frame.size.width/5*3, self.view.frame.size.height/5+80, 100, 40);
    stop.font = [UIFont systemFontOfSize:20];
    stop.tintColor = [UIColor blackColor];
    [stop addTarget:self action:@selector(stoprecord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stop];

}

- (void)startrecord{
    [recognizer start];
}

- (void)stoprecord{
    [recognizer stop];
    solutionview.frame = CGRectMake(2, 445 , Thermometer.frame.size.width-4, 0);
}

-(void)recognizer:(KKNoiseRecognizer *)recognizer StartUpdateNoiseLevel:(int)level {
    self.curlabel.text = [NSString stringWithFormat:@"%d dB",0];
}

-(void)recognizer:(KKNoiseRecognizer *)recognizer StopUpdateNoiseLevel:(int)level {
    self.curlabel.text = [NSString stringWithFormat:@"%d dB",0];
}

-(void)recognizer:(KKNoiseRecognizer *)recognizer updateNoiseLevel:(int)level {
    self.curlabel.text = [NSString stringWithFormat:@"%d dB",level];
    solutionview.frame = CGRectMake(2, 445-3.75*level , Thermometer.frame.size.width-4, 3.75*level);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
