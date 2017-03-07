//
//  UIColor+LH.m
//  auto
//
//  Created by bangong on 17/3/2.
//  Copyright © 2017年 车质网. All rights reserved.
//

#import "UIColor+LH.h"

@implementation UIColor (LH)


+ (UIColor *)HexColor:(NSString *)colorString
{
    unsigned long colorLong = strtoul(colorString.UTF8String, 0, 16);
    //通过位与方法获取三色值
    int R = (colorLong & 0xFF0000) >> 16;
    int G = (colorLong & 0x00FF00) >> 8;
    int B = colorLong & 0x0000FF;

    return [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:1.f];
}

@end
