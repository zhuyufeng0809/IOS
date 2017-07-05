//
//  PanelMiddleView.m
//  WETECHCushion
//
//  Created by Will Hu on 5/7/16.
//  Copyright © 2016 ___WETECH___. All rights reserved.
//

#import "PanelMiddleView.h"
#import "MacroDefinition.h"

@interface PanelMiddleView()

@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *middleLineView;
@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, strong) UIImageView *carImageView;
@property (nonatomic, strong) UIImageView *seatImageView;

@property (nonatomic, strong) UILabel *carTemperatureLabel;
@property (nonatomic, strong) UILabel *seatTemperatureLabel;

@property (nonatomic, strong) UILabel *carTempValueLabel;
@property (nonatomic, strong) UILabel *seatTempValueLabel;


@end

@implementation PanelMiddleView

#pragma mark - Private properties

- (UIView*)topLineView
{
    if (!_topLineView) {
        _topLineView = [UIView new];
        _topLineView.backgroundColor = [UIColor grayColor];
        _topLineView.hidden = NO;
    }
    return _topLineView;
}

- (UIView*)middleLineView
{
    if (!_middleLineView) {
        _middleLineView = [UIView new];
        _middleLineView.backgroundColor = [UIColor grayColor];
        _middleLineView.hidden = NO;
    }
    return _middleLineView;
}

- (UIView*)bottomLineView
{
    if (!_bottomLineView) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = [UIColor grayColor];
        _bottomLineView.hidden = NO;
    }
    return _bottomLineView;
}

- (UIImageView*)carImageView
{
    if (!_carImageView) {
        _carImageView = [UIImageView new];
        _carImageView.backgroundColor = [UIColor clearColor];
        _carImageView.hidden = NO;
        _carImageView.image = [UIImage imageNamed:@"carImage"];
    }
    return _carImageView;
}

- (UIImageView*)seatImageView
{
    if (!_seatImageView) {
        _seatImageView = [UIImageView new];
        _seatImageView.backgroundColor = [UIColor clearColor];
        _seatImageView.hidden = NO;
        _seatImageView.image = [UIImage imageNamed:@"seatImage"];
    }
    return _seatImageView;
}

- (UILabel*)carTemperatureLabel
{
    if (!_carTemperatureLabel) {
        _carTemperatureLabel = [UILabel new];
        _carTemperatureLabel.backgroundColor = [UIColor clearColor];
        _carTemperatureLabel.hidden = NO;
        _carTemperatureLabel.text = @"车厢温度";
        _carTemperatureLabel.textAlignment = NSTextAlignmentCenter;
        _carTemperatureLabel.textColor = [UIColor grayColor];
    }
    return _carTemperatureLabel;
}

- (UILabel*)seatTemperatureLabel
{
    if (!_seatTemperatureLabel) {
        _seatTemperatureLabel = [UILabel new];
        _seatTemperatureLabel.backgroundColor = [UIColor clearColor];
        _seatTemperatureLabel.hidden = NO;
        _seatTemperatureLabel.text = @"坐垫温度";
        _seatTemperatureLabel.textAlignment = NSTextAlignmentCenter;
        _seatTemperatureLabel.textColor = [UIColor grayColor];
    }
    return _seatTemperatureLabel;
}

- (UILabel*)carTempValueLabel
{
    if (!_carTempValueLabel) {
        _carTempValueLabel = [UILabel new];
        _carTempValueLabel.backgroundColor = [UIColor clearColor];
        _carTempValueLabel.hidden = NO;
//        _carTempValueLabel.text = @"车厢温度";
        _carTempValueLabel.textAlignment = NSTextAlignmentLeft;
        _carTempValueLabel.textColor = MAIN_BLUE_COLOR;
        _carTempValueLabel.font = [UIFont boldSystemFontOfSize:30];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"30\u00b0c"];
        [attributedString setAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-light" size:20.0]
                                          , NSBaselineOffsetAttributeName : @15} range:NSMakeRange(2, 2)];
        _carTempValueLabel.attributedText = attributedString;
    }
    return _carTempValueLabel;
}

- (UILabel*)seatTempValueLabel
{
    if (!_seatTempValueLabel) {
        _seatTempValueLabel = [UILabel new];
        _seatTempValueLabel.backgroundColor = [UIColor clearColor];
        _seatTempValueLabel.hidden = NO;
//        _seatTempValueLabel.text = @"坐垫温度";
        _seatTempValueLabel.textAlignment = NSTextAlignmentLeft;
        _seatTempValueLabel.textColor = MAIN_BLUE_COLOR;
        _seatTempValueLabel.font = [UIFont boldSystemFontOfSize:30];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"20\u00b0c"];
        [attributedString setAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-light" size:20.0]
                                          , NSBaselineOffsetAttributeName : @15} range:NSMakeRange(2, 2)];
        _seatTempValueLabel.attributedText = attributedString;
    }
    return _seatTempValueLabel;
}

#pragma mark - Set temperature

- (void)setTemperatureWithType:(NSInteger)nType AndTemperature:(NSInteger)nTemperature
{
    if (nTemperature <= 0) {
        return;
    }
    switch (nType) {
        case TEMP_CAR:
        {
            NSLog(@"set temperature with type, %d", (unsigned char)nTemperature);
            NSString *temperatureString = [NSString stringWithFormat:@"%d\u00b0c", (unsigned char)nTemperature];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:temperatureString];
            [attributedString setAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-light" size:20.0]
                                          , NSBaselineOffsetAttributeName : @15} range:NSMakeRange(2, 2)];
            _carTempValueLabel.attributedText = attributedString;
            break;
        }
        case TEMP_CUSHION:
        {
            NSString *temperatureString = [NSString stringWithFormat:@"%d\u00b0c", (unsigned char)nTemperature];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:temperatureString];
            [attributedString setAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-light" size:20.0]
                                          , NSBaselineOffsetAttributeName : @15} range:NSMakeRange(2, 2)];
            _seatTempValueLabel.attributedText = attributedString;
            break;
        }
            
        default:
            break;
    }
    
}

#pragma mark - View lifecycle

- (void)addSubviewTree
{
    [self addSubview:self.topLineView];
    [self addSubview:self.middleLineView];
    [self addSubview:self.bottomLineView];
    
    [self addSubview:self.carImageView];
    [self addSubview:self.seatImageView];
    [self addSubview:self.carTemperatureLabel];
    [self addSubview:self.seatTemperatureLabel];
    [self addSubview:self.carTempValueLabel];
    [self addSubview:self.seatTempValueLabel];
}

- (void)setViewsLayout
{
    [self.topLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        
        make.height.equalTo(@(1));
    }];
    
    [self.middleLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.centerX.equalTo(self.centerX);
        make.bottom.equalTo(self.bottom);
        
        make.width.equalTo(@(1));
    }];
    
    [self.bottomLineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.bottom.equalTo(self.bottom);
        
        make.height.equalTo(@(1));
    }];
    
    [self.carImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(20);
        make.centerY.equalTo(self.centerY);
        
        make.width.equalTo(@(68));
        make.height.equalTo(@(60));
    }];
    
    [self.seatImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleLineView.right).offset(19);
        make.centerY.equalTo(self.centerY);
        
        make.width.equalTo(@(64));
        make.height.equalTo(@(64));
    }];
    
    [self.carTemperatureLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.carImageView.centerX);
        make.top.equalTo(self.carImageView.bottom).offset(5);
        
        make.width.equalTo(@(80));
        make.height.equalTo(@(20));
    }];
    
    [self.seatTemperatureLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.seatImageView.centerX);
        make.top.equalTo(self.seatImageView.bottom).offset(5);
        
        make.width.equalTo(@(80));
        make.height.equalTo(@(20));
    }];
    
    [self.carTempValueLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carImageView.right).offset(15);
        make.centerY.equalTo(self.centerY);
        
        make.width.equalTo(@(60));
        make.height.equalTo(@(60));
    }];
    
    [self.seatTempValueLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.seatImageView.right).offset(15);
        make.centerY.equalTo(self.centerY);
        
        make.width.equalTo(@(60));
        make.height.equalTo(@(60));
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
