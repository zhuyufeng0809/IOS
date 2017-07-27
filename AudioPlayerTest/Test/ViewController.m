//
//  ViewController.m
//  Test
//
//  Created by 朱育锋 on 17/7/25.
//  Copyright © 2017年 朱育锋. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()
{
    AVAudioPlayer * _player;
    UISlider * _volume;
    UISlider * _soundTrack;
    UISlider * _speed;
    UILabel * time;
    NSTimer * _timer;
    NSMutableDictionary * dict;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL * url = [[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"童话镇" ofType:@"mp3"]];
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    if ([_player prepareToPlay]) {
        [_player play];
    }
    _player.enableRate = YES;
    
    _volume = [[UISlider alloc]initWithFrame:CGRectMake(80, 100, 200, 30)];
    _volume.minimumValue = 0;
    _volume.maximumValue = 1;
    _volume.value = 0.5;
    _volume.continuous =YES;
    [_volume addTarget:self action:@selector(changevolume) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_volume];
    
    _soundTrack = [[UISlider alloc]initWithFrame:CGRectMake(80, 200, 200, 30)];
    _soundTrack.minimumValue = 0;
    _soundTrack.maximumValue = 1;
    _soundTrack.value = 0.5;
    _soundTrack.continuous = YES;
    [_soundTrack addTarget:self action:@selector(changesoundtarck) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_soundTrack];
    
    _speed = [[UISlider alloc]initWithFrame:CGRectMake(80, 300, 200, 30)];
    _speed.minimumValue = 0;
    _speed.maximumValue = 1;
    _speed.value = 0.5;
    _speed.continuous = YES;
    [_speed addTarget:self action:@selector(changespeed) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_speed];
    
    UILabel * first = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 40, 30)];
    first.text = @"音量";
    first.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:first];
    
    UILabel * second = [[UILabel alloc]initWithFrame:CGRectMake(20, 200, 40, 30)];
    second.text = @"声道";
    second.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:second];
    
    UILabel * third = [[UILabel alloc]initWithFrame:CGRectMake(20, 300, 40, 30)];
    third.text = @"速度";
    third.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:third];
    
    UIButton * startBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [startBtn setTitle:@"播放" forState:UIControlStateNormal];
    startBtn.frame = CGRectMake(50, 400, 30, 30);
    [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    UIButton * pauseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    pauseBtn.frame = CGRectMake(100, 400, 30, 30);
    [pauseBtn addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseBtn];
    
    UIButton * stopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [stopBtn setTitle:@"停止" forState:UIControlStateNormal];
    stopBtn.frame = CGRectMake(150, 400, 30, 30);
    [stopBtn addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    
    time = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/5*4, 100, 50)];
    time.text = @"时间";
    [self.view addSubview:time];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1/60 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    _timer.fireDate = [NSDate distantPast];
    
    dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"童话镇" forKey:MPMediaItemPropertyTitle];
    [dict setObject:@"周一发" forKey:MPMediaItemPropertyArtist];
    [dict setObject:@"童话镇" forKey:MPMediaItemPropertyAlbumTitle];
    UIImage * image = [UIImage imageNamed:@"滑稽"];
    [dict setObject:[[MPMediaItemArtwork alloc] initWithImage:image ]forKey:MPMediaItemPropertyArtwork];
    [dict setObject:[NSNumber numberWithDouble:300] forKey:MPMediaItemPropertyPlaybackDuration];
    [dict setObject:[NSNumber numberWithDouble:150] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
}

- (void)changevolume{
    float value = _volume.value;
    _player.volume = value;
}

- (void)changesoundtarck{
    float value = -1+2*_soundTrack.value;
    _player.pan = value;
}

- (void)changespeed{
    float value = _speed.value+0.5;
    _player.rate = value;
}

- (void)start{
    if (_player.playing) {
        return;
    }
    [_player play];
}

- (void)pause{
    if (_player.isPlaying) {
        [_player pause];
    }
}

- (void)stop{
    if ([_player isPlaying]) {
        [_player stop];
    }
}

- (void)updateProgress{
    int current = _player.currentTime;
    int duration = _player.duration;
    time.text = [NSString stringWithFormat:@"%02d:%02d/%02d:%02d",current/60,current%60,duration/60,duration%60];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
