//
//  SettingTitleView.h
//  WETECHCushion
//
//  Created by iDev on 6/4/16.
//  Copyright © 2016 ___WETECH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTitleView : UIView

@property (nonatomic, strong)UIImage *titleImage;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)NSString *titleLabelText;
@property (nonatomic, strong)UIFont *titleLabelFont;

- (void)simulateViewDidLoad;

@end
