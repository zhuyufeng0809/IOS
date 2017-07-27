//
//  ViewController.m
//  noiseTest
//
//  Created by 朱育锋 on 17/7/17.
//  Copyright © 2017年 朱育锋. All rights reserved.
//

#import "ViewController.h"
#import "UICountingLabel/UICountingLabel.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
{
    AVAudioRecorder * recorder;
    NSTimer * levelTimer;
    UICountingLabel * curlabel;
    float   level;
    int ans;
    UIImageView * solutionview;
    UIImageView * Thermometer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*0.6, self.view.frame.size.height)];
    leftview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:leftview];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(self.view.frame.size.width*0.75, self.view.frame.size.height*0.8, 25, 25);
    [self.view addSubview:btn];
    
    UILabel * average = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.63, self.view.frame.size.height*0.2, 110, 50)];
    average.text = @"1分钟平均水平(dB)";
    average.font = [UIFont systemFontOfSize:13];
    average.textColor = [UIColor grayColor];
    [self.view addSubview:average];
    
    UILabel * current = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.68, self.view.frame.size.height*0.5, 80, 50)];
    current.font = [UIFont systemFontOfSize:13];
    current.textColor = [UIColor grayColor];
    current.text = @"当前数值(dB)";
    [self.view addSubview:current];
    //
    UICountingLabel * avlabel = [[UICountingLabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.65, self.view.frame.size.height*0.28, 90, 80)];
    avlabel.textAlignment = NSTextAlignmentCenter;
    avlabel.font = [UIFont fontWithName:@"Avenir Next" size:48];
    avlabel.textColor = [UIColor blackColor];
    [self.view addSubview:avlabel];
    avlabel.format = @"%d";
    [avlabel countFrom:0 to:110 withDuration:1.5];
    
    ///////////////////////
    
    
    curlabel = [[UICountingLabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.65, self.view.frame.size.height*0.58, 110, 80)];
    curlabel.textAlignment = NSTextAlignmentCenter;
    curlabel.font = [UIFont fontWithName:@"Avenir Next" size:48];
    curlabel.textColor = [UIColor blackColor];
    [self.view addSubview:curlabel];
    //curlabel.format = @"%.d";
    
    
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
    //
    /* 必须添加这句话，否则在模拟器可以，在真机上获取始终是0  */
    [[AVAudioSession sharedInstance]
     setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
    
    /* 不需要保存录音文件 */
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
                              [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                              [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                              [NSNumber numberWithInt: AVAudioQualityMax], AVEncoderAudioQualityKey,
                              nil ];
    NSError *error;
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if (recorder)
    {
        [recorder prepareToRecord];
        recorder.meteringEnabled = YES;
        [recorder record];
        levelTimer = [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    }
    else
    {
        NSLog(@"%@", [error description]);
    }
    
}

- (void)levelTimerCallback:(NSTimer *)timer {
    [recorder updateMeters];
    
    // float   level;                // The linear 0.0 .. 1.0 value we need.
    float   minDecibels = -80.0f; // Or use -60dB, which I measured in a silent room.
    float   decibels    = [recorder averagePowerForChannel:0];
    
    if (decibels < minDecibels)
    {
        level = 0.0f;
    }
    else if (decibels >= 0.0f)
    {
        level = 1.0f;
    }
    else
    {
        float   root            = 2.0f;
        float   minAmp          = powf(10.0f, 0.05f * minDecibels);
        float   inverseAmpRange = 1.0f / (1.0f - minAmp);
        float   amp             = powf(10.0f, 0.05f * decibels);
        float   adjAmp          = (amp - minAmp) * inverseAmpRange;
        
        level = powf(adjAmp, 1.0f / root);
    }
    
    ans = level*2500;
    //[curlabel countFromZeroTo:ans withDuration:0.5];
    
    curlabel.text = [NSString stringWithFormat:@"%d",ans];
    solutionview.frame = CGRectMake(2, 445-3.75*ans , Thermometer.frame.size.width-4, 3.75*ans);
    /* level 范围[0 ~ 1], 转为[0 ~120] 之间 */
    /*dispatch_async(dispatch_get_main_queue(), ^{
     [curlabel setText:[NSString stringWithFormat:@"%d",ans]];
     });*/
}

- (void)dealloc {
    [levelTimer release];
    [recorder release];
    [curlabel release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end