//
//  StandardViewController.m
//  noiseTest
//
//  Created by 朱育锋 on 17/7/24.
//  Copyright © 2017年 朱育锋. All rights reserved.
//

#import "StandardViewController.h"
#import <Waver/Waver.h>
#import <AVFoundation/AVFoundation.h>
#import "XHSoundRecorder.h"
#import "XHTableViewController.h"

@interface StandardViewController ()
{
    UIButton * record;
    UIButton * play;
}

@property (nonatomic, strong) AVAudioRecorder *recorder;
@property NSURL *recordUrl;
@property AVAudioPlayer * audioPlayer;

@property (nonatomic, strong) NSMutableArray *filePaths;
@property (nonatomic, copy) NSString *file;

@end

@implementation StandardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self setupRecorder];
    
    Waver * waver = [[Waver alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)/2.0 - 50.0, CGRectGetWidth(self.view.bounds), 100.0)];
    
    __block AVAudioRecorder *weakRecorder = self.recorder;
    
    waver.waverLevelCallback = ^(Waver * waver) {
        
        [weakRecorder updateMeters];
        
        CGFloat normalizedValue = pow (10, [weakRecorder averagePowerForChannel:0] / 40);
        
        waver.level = normalizedValue;
        
    };
    
    [self.view addSubview:waver];
    
    record = [UIButton buttonWithType:UIButtonTypeSystem];
    [record setTitle:@"开始录音" forState:UIControlStateNormal];
    record.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/5, 100, 30);
    [record addTarget:self action:@selector(recorders) forControlEvents:UIControlEventTouchUpInside];
    record.tintColor = [UIColor blackColor];
    [self.view addSubview:record];
    
    UIButton * pauseRecord = [UIButton buttonWithType:UIButtonTypeSystem];
    [pauseRecord setTitle:@"暂停录音" forState:UIControlStateNormal];
    pauseRecord.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/5+50, 100, 30);
    [pauseRecord addTarget:self action:@selector(pauseRecord) forControlEvents:UIControlEventTouchUpInside];
    pauseRecord.tintColor = [UIColor blackColor];
    [self.view addSubview:pauseRecord];
    
    
    UIButton * stoprecord = [UIButton buttonWithType:UIButtonTypeSystem];
    [stoprecord setTitle:@"停止录音" forState:UIControlStateNormal];
    stoprecord.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/5+100, 100, 30);
    [stoprecord addTarget:self action:@selector(stoprecord) forControlEvents:UIControlEventTouchUpInside];
    stoprecord.tintColor = [UIColor blackColor];
    [self.view addSubview:stoprecord];
    
    
    
    play = [UIButton buttonWithType:UIButtonTypeSystem];
    [play setTitle:@"播放" forState:UIControlStateNormal];
    play.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2+10, 100, 30);
    [play addTarget:self action:@selector(playrecorder) forControlEvents:UIControlEventTouchUpInside];
    play.tintColor = [UIColor blackColor];
    [self.view addSubview:play];
    
    UIButton * pause = [UIButton buttonWithType:UIButtonTypeSystem];
    [pause setTitle:@"暂停播放" forState:UIControlStateNormal];
    pause.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2+60, 100, 30);
    [pause addTarget:self action:@selector(pauseplay) forControlEvents:UIControlEventTouchUpInside];
    pause.tintColor = [UIColor blackColor];
    [self.view addSubview:pause];
    
    UIButton * pausePlay = [UIButton buttonWithType:UIButtonTypeSystem];
    [pausePlay setTitle:@"停止播放" forState:UIControlStateNormal];
    pausePlay.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2+110, 100, 30);
    [pausePlay addTarget:self action:@selector(stopplay) forControlEvents:UIControlEventTouchUpInside];
    pausePlay.tintColor = [UIColor blackColor];
    [self.view addSubview:pausePlay];
    
    UIButton * delete = [UIButton buttonWithType:UIButtonTypeSystem];
    [delete setTitle:@"删除录音" forState:UIControlStateNormal];
    delete.frame = CGRectMake(self.view.frame.size.width/3-80, self.view.frame.size.height/2+160, 100, 30);
    [delete addTarget:self action:@selector(deletterecord) forControlEvents:UIControlEventTouchUpInside];
    delete.tintColor = [UIColor blackColor];
    [self.view addSubview:delete];
    
    
    UIButton * change = [UIButton buttonWithType:UIButtonTypeSystem];
    [change setTitle:@"转换MP3格式" forState:UIControlStateNormal];
    change.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2+160, 100, 30);
    [change addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    change.tintColor = [UIColor blackColor];
    [self.view addSubview:change];
    
    UIButton * all = [UIButton buttonWithType:UIButtonTypeSystem];
    [all setTitle:@"所有录音" forState:UIControlStateNormal];
    all.frame = CGRectMake(self.view.frame.size.width/3*2-20, self.view.frame.size.height/2+160, 100, 30);
    [all addTarget:self action:@selector(allreocrd) forControlEvents:UIControlEventTouchUpInside];
    all.tintColor = [UIColor blackColor];
    [self.view addSubview:all];
    
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(
                                                            NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"recordTest.caf"];
    
    NSURL *urls = [NSURL fileURLWithPath:soundFilePath];
    self.recordUrl=urls;
    
    
    
    self.title = @"录音";
    CGFloat decibels = [[XHSoundRecorder sharedSoundRecorder] decibels];
}

- (NSMutableArray *)filePaths {
    
    if (!_filePaths) {
        
        _filePaths = [NSMutableArray array];
    }
    
    return _filePaths;
}

-(void)setupRecorder
{
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    
    NSDictionary *settings = @{AVSampleRateKey:          [NSNumber numberWithFloat: 44100.0],
                               AVFormatIDKey:            [NSNumber numberWithInt: kAudioFormatAppleLossless],
                               AVNumberOfChannelsKey:    [NSNumber numberWithInt: 2],
                               AVEncoderAudioQualityKey: [NSNumber numberWithInt: AVAudioQualityMin]};
    
    NSError *error;
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    
    if(error) {
        NSLog(@"Ups, could not create recorder %@", error);
        return;
    }
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    
    if (error) {
        NSLog(@"Error setting category: %@", [error description]);
    }
    
    [self.recorder prepareToRecord];
    [self.recorder setMeteringEnabled:YES];
    [self.recorder record];
    
    ///
    
}

- (void)recorders{
    typeof(self) wSelf = self;
    
    [[XHSoundRecorder sharedSoundRecorder] startRecorder:^(NSString *filePath) {
        
        NSLog(@"录音文件路径:%@",filePath);
        
        NSLog(@"录音结束");
        
        [wSelf.filePaths addObject:filePath];
        
        wSelf.file = filePath;
    }];
    
    [record setTitle:@"正在录音" forState:UIControlStateNormal];
}


- (void)pauseRecord{
    [[XHSoundRecorder sharedSoundRecorder] pauseRecorder];
    
    [record setTitle:@"继续录音" forState:UIControlStateNormal];
}

- (void)stoprecord{
    [[XHSoundRecorder sharedSoundRecorder] stopRecorder];
    
    [record setTitle:@"录音" forState:UIControlStateNormal];
}

- (void)pauseplay{
    [[XHSoundRecorder sharedSoundRecorder] pausePlaysound];
    
    [play setTitle:@"继续播放" forState:UIControlStateNormal];
}


- (void)stopplay{
    [[XHSoundRecorder sharedSoundRecorder] stopPlaysound];
    
    [play setTitle:@"播放" forState:UIControlStateNormal];
}


- (NSDictionary *)audioRecordingSettings{
    
    NSDictionary *result = nil;
    
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    //    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatAppleLossless] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    result = [NSDictionary dictionaryWithDictionary:recordSetting];
    return result;
}

- (void)deletterecord{
    [[XHSoundRecorder sharedSoundRecorder] removeSoundRecorder];
    
    [self.filePaths removeLastObject];
}

- (void)playrecorder{
    typeof(self) wSelf = self;
    
    [[XHSoundRecorder sharedSoundRecorder] playsound:nil withFinishPlaying:^{
        
        NSLog(@"播放结束");
        
        [play setTitle:@"播放" forState:UIControlStateNormal];
    }];
    
    [play setTitle:@"正在播放" forState:UIControlStateNormal];
    
}

- (void)change{
    typeof(self) wSelf = self;
    
    [[XHSoundRecorder sharedSoundRecorder] recorderFileToMp3WithType:Simulator filePath:nil FilePath:^(NSString *newfilePath) {
        
        NSLog(@"转换之后的路径:%@",newfilePath);
        
        [wSelf.filePaths removeObject:self.file];
        
        [wSelf.filePaths addObject:newfilePath];
        
    }];
}

- (void)allreocrd{
    XHTableViewController *table = [[XHTableViewController alloc] init];
    
    table.filePaths = self.filePaths;
    
    [self.navigationController pushViewController:table animated:YES];
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
