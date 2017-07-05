//
//  PanelMiddleView.h
//  WETECHCushion
//
//  Created by Will Hu on 5/7/16.
//  Copyright © 2016 ___WETECH___. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TEMP_CURRENT_SETTING    1
#define TEMP_CAR                2
#define TEMP_CUSHION            3

@interface PanelMiddleView : UIView


- (void)simulateViewDidLoad;
- (void)setTemperatureWithType:(NSInteger)nType AndTemperature:(NSInteger)nTemperature;

@end
