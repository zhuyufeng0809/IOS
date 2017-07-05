//
//  PanelBottomView.h
//  WETECHCushion
//
//  Created by Will Hu on 5/7/16.
//  Copyright © 2016 ___WETECH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PanelMiddleView;

@interface PanelBottomView : UIView

@property (nonatomic, strong) PanelMiddleView *middleView;

- (void)simulateViewDidLoad;

@end
