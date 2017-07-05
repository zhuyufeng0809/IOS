//
//  MacroDefinition.h
//  WETECHCushion
//
//  Created by Will Hu on 5/8/16.
//  Copyright © 2016 ___WETECH___. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define MAIN_BLUE_COLOR COLOR(79, 190, 245, 1.0)
#define MAIN_BLUE_COLOR_TRANSLUCENCE COLOR(79, 190, 245, 0.5);
//translucence
#endif /* MacroDefinition_h */
