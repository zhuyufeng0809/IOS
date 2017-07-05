//
//  TColorfulTabBar+Configuration.m
//  2015-07-01-ColorfulTabBarAnimation
//
//  Created by TangJR on 7/2/15.
//  Copyright (c) 2015 tangjr. All rights reserved.
//

#import "TColorfulTabBar+Configuration.h"
#import "UIColor+STColorInit.h"

@implementation TColorfulTabBar (Configuration)

- (NSArray *)itemColors {
    
    return @[MAIN_BLUE_COLOR,MAIN_BLUE_COLOR];
}

- (NSInteger)itemCount {
    
    return 2;
}

@end