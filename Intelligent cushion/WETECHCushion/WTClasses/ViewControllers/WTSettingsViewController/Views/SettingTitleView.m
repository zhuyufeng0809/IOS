//
//  SettingTitleView.m
//  WETECHCushion
//
//  Created by iDev on 6/4/16.
//  Copyright © 2016 ___WETECH___. All rights reserved.
//

#import "SettingTitleView.h"

@interface SettingTitleView()

@property (nonatomic, strong)UIImageView *titleImageView;
@property (nonatomic, strong)UIImageView *lineImageView;

@end

@implementation SettingTitleView

-(UIImageView*)titleImageView{
    if(!_titleImageView){
        _titleImageView = [UIImageView new];
        _titleImageView.backgroundColor = [UIColor clearColor];
        _titleImageView.hidden = NO;
        _titleImageView.image = _titleImage;
    }
    return _titleImageView;
}

-(UILabel*)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel new];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.hidden = NO;
        _titleLabel.text = _titleLabelText;
        _titleLabel.textColor = [UIColor grayColor];
        if(!_titleLabelFont){
            _titleLabel.font = [UIFont fontWithName:@"Heiti SC" size:13];
        }else{
            _titleLabel.font = _titleLabelFont;
        }
    }
    return _titleLabel;
}

-(UIImageView*)lineImageView{
    if(!_lineImageView){
        _lineImageView = [UIImageView new];
        _lineImageView.backgroundColor = [UIColor clearColor];
        _lineImageView.hidden = NO;
        _lineImageView.image = [[UIImage imageNamed:@"horizonImage"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    return _lineImageView;
}

- (void) addSubviewTree{
    [self addSubview:[self titleImageView]];
    [self addSubview:[self titleLabel]];
    [self addSubview:[self lineImageView]];
}

- (void) setViewsLayout{
    [_titleImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        
        make.width.equalTo(self.mas_height).multipliedBy(0.95);
        make.height.equalTo(self.mas_height).multipliedBy(0.95);
    }];
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY);
        
        make.width.equalTo(self.mas_height).multipliedBy(1.2);
        make.height.equalTo(self.mas_height).multipliedBy(0.95);
    }];
    
    [_lineImageView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self.centerX);
        
        make.width.equalTo(self.mas_width).multipliedBy(5);
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
