//
//  CRCommon.h
//  Zyys
//
//  Created by 蔡军伟 on 15/7/27.
//  Copyright (c) 2015年 CaiJunwei. All rights reserved.
//

#ifndef Zyys_CRCommon_h
#define Zyys_CRCommon_h



//获得RGB颜色值
#define CRColor(r,g,b) [UIColor colorWithRed:(r)/255.0  green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


//主体背景颜色
#define CRMainBackgroundColor CRColor(185,225,250)
//标题栏颜色
#define CRTitleBarColor CRColor(79,196,38)


//TabBar的item选中时的颜色
#define CRDockSelectColor CRColor(78,181,247)
#define CRDockBackgroundColor CRColor(220,237,247)

//按钮高亮时的颜色
#define CRButtonNomalColor CRColor(78,181,247)
#define CRButtonHighlight CRColor(0x1c,0x86,0xee)

//文本输入框的背景色
#define CRTextFiledBgColor CRColor(200,237,247)



#define CRFindPwLabelColor CRColor(29,175,162)


//tabbar背景颜色
#define CRTabbarBgColor CRColor(79,196,38)
#define CRButtonColorSelected CRColor(58,149,18)

#endif
