//
//  Theme.h
//  BasicFramework
//
//  Created by Rainy on 16/8/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#ifndef Theme_h
#define Theme_h

#pragma mark -  * * * * * * * * * * * * * * 主题 * * * * * * * * * * * * * *

#define RGB_color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define colorDeepBlack RGB_color(17,17,17,1)//标题深黑
#define colorBlack RGB_color(51,51,51,1)//标题浅黑
#define colorDeepGray RGB_color(102,102,102,1)//深灰
#define colorLightGray RGB_color(153,153,153,1)//浅灰
#define colorLineGray RGB_color(221,221,221,1)//线条灰

#define colorDeepBlue RGB_color(0,125,184,1)//深蓝
#define colorLightBlue RGB_color(0,159,251,1)//浅蓝
#define colorGreen RGB_color(27,188,157,1)//绿色
#define colorPurple RGB_color(171,92,158,1)//紫色
#define colorYellow RGB_color(247,162,0,1)//文字黄
#define colorOrangeRed RGB_color(237,27,36,1)//橙红色
#define colorBackGround RGB_color(240,240,240,1)//区域背景色

/**
 *  无色
 */
#define kClearColor [UIColor clearColor]
/**
 *  默认页面背景色
 */
#define DefaultBackGroundColor UIColorFromRGBValue(0Xf5f7fa)
/**
 *  默认白色
 */
#define WhiteColor UIColorFromRGBValue(0Xffffff)
/**
 *  主题颜色
 */
#define ThemeColor UIColorFromRGBValue(0X0096f4)
/**
 *  主题辅助颜色（状态，提示等...）
 */
#define OrangeColor UIColorFromRGBValue(0Xef5a50)
/**
 *  遮盖半透明色
 */
#define kCoverColor [UIColorFromRGBValue(0X000000)colorWithAlphaComponent:0.3]

/**
 *  分割线灰色等...
 */
#define kBackDefaultGrayColor UIColorFromRGBValue(0Xdbdfe8)
/**
 *  主要字体颜色
 */
#define kMainFontColor UIColorFromRGBValue(0X333333)
/**
 *  次要字体颜色
 */
#define kSecondaryFontColor UIColorFromRGBValue(0X999999)
/**
 *  辅助字体颜色
 */
#define kAuxiliaryFontColor UIColorFromRGBValue(0Xcccccc)
/**
 *  默认字体颜色(非点击状态)
 */
#define kNormalFontColor UIColorFromRGBValue(0X999999)


#pragma mark -  * * * * * * * * * * * * * * set Font * * * * * * * * * * * * * *
/**
 *  10号字体
 */
#define TenFontSize [UIFont systemFontOfSize:10]
/**
 *  11号字体
 */
#define ElevenFontSize [UIFont systemFontOfSize:11]
/**
 *  12号字体
 */
#define TwelveFontSize [UIFont systemFontOfSize:12]
/**
 *  13号字体
 */
#define ThirteenFontSize [UIFont systemFontOfSize:13]
/**
 *  14号字体
 */
#define FourteenFontSize [UIFont systemFontOfSize:14]
/**
 *  15号字体
 */
#define FifteenFontSize [UIFont systemFontOfSize:15]
/**
 *  17号字体
 */
#define SeventeenFontSize [UIFont systemFontOfSize:17]
/**
 *  18号字体
 */
#define EighteenFontSize [UIFont systemFontOfSize:18]
/**
 *  20号字体
 */
#define TwentyFontSize [UIFont systemFontOfSize:20]




#pragma mark -  * * * * * * * * * * * * * * set Button * * * * * * * * * * * * * *
/**
 *  按钮的背景默认颜色
 */
#define kButtonBackColorForNormal UIColorFromRGBValue(0X0097f4)
/**
 *  按钮的背景点击颜色
 */
#define kButtonBackColorForSelect UIColorFromRGBValue(0X008ce3)
/**
 *  按钮的背景不可点击颜色
 */
#define kButtonBackColorForDisabled UIColorFromRGBValue(0X7fcaf9)
/**
 *  按钮的圆角
 */
#define kButtonCornerRad 5


//十六进制颜色
#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define kRGB_alpha(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]


#endif /* Theme_h */
