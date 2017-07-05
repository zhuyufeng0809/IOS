//
//  PanelTopView.m
//  WETECHCushion
//
//  Created by Will Hu on 5/7/16.
//  Copyright © 2016 ___WETECH___. All rights reserved.
//

#import "PanelTopView.h"

@interface PanelTopView()

@property (nonatomic, strong) UIImageView *weatherImageView;

@property (nonatomic, strong) UILabel *todayTemperatureLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;


@end

@implementation PanelTopView

#pragma mark - Private properties


- (UIImageView*)weatherImageView
{
    if (!_weatherImageView) {
        _weatherImageView = [UIImageView new];
        _weatherImageView.backgroundColor = [UIColor clearColor];
        _weatherImageView.hidden = NO;
        _weatherImageView.image = [UIImage imageNamed:@"weatherImage"];
    }
    return _weatherImageView;
}

- (UILabel*)todayTemperatureLabel
{
    if (!_todayTemperatureLabel) {
        _todayTemperatureLabel = [UILabel new];
        _todayTemperatureLabel.backgroundColor = [UIColor clearColor];
        _todayTemperatureLabel.hidden = NO;
        _todayTemperatureLabel.text = @"今\n日\n气\n温";
        _todayTemperatureLabel.numberOfLines = 4;
        _todayTemperatureLabel.textAlignment = NSTextAlignmentCenter;
        _todayTemperatureLabel.textColor = [UIColor whiteColor];
        _todayTemperatureLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _todayTemperatureLabel;
}

- (UILabel*)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.hidden = NO;
        _timeLabel.text = _timeLabelText;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _timeLabel;
}

- (UILabel*)temperatureLabel
{
    if (!_temperatureLabel) {
        _temperatureLabel = [UILabel new];
        _temperatureLabel.backgroundColor = [UIColor clearColor];
        _temperatureLabel.hidden = NO;
        _temperatureLabel.textAlignment = NSTextAlignmentLeft;
        _temperatureLabel.textColor = [UIColor whiteColor];
        _temperatureLabel.font = [UIFont boldSystemFontOfSize:35];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"22\u00b0c"];
        [attributedString setAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-light" size:20.0]
                                          , NSBaselineOffsetAttributeName : @15} range:NSMakeRange(2, 2)];
        _temperatureLabel.attributedText = attributedString;
    }
    return _temperatureLabel;
}

#pragma mark - View lifecycle

- (void)addSubviewTree
{
    [self addSubview:self.weatherImageView];
    
    [self addSubview:self.todayTemperatureLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.temperatureLabel];
}

- (void)setViewsLayout
{
    [self.todayTemperatureLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(8);
        make.left.equalTo(self.left).offset(15);
        make.bottom.equalTo(self.bottom);
        
        make.width.equalTo(@(20));
    }];
    
    [self.weatherImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.left).offset(SCREEN_WIDTH/2+15);
       
        make.width.equalTo(@(62));
        make.height.equalTo(@(62));
    }];
    
    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(12);
        make.left.equalTo(self.todayTemperatureLabel.right).offset(20);
        
        make.width.equalTo(@(100));
        make.height.equalTo(@(25));
    }];
    
    [self.temperatureLabel makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.timeLabel.bottom).offset(15);
        make.top.equalTo(self.top).offset(27);
        make.left.equalTo(self.todayTemperatureLabel.right).offset(20);
        
        make.width.equalTo(@(70));
        make.height.equalTo(@(70));
    }];
    
    
}

- (void)initViews
{
    [self setViewsLayout];
}

- (void)simulateViewDidLoad
{
    [self addSubviewTree];
    [self initViews];
}


@end
