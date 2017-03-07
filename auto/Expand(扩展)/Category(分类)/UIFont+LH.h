//
//  UIFont+LH.h
//  chezhiwang
//
//  Created by bangong on 16/6/22.
//  Copyright © 2016年 车质网. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (LH)
//行楷
+ (NSString *)fontNameSTXingkai_SC_Bold;
+ (void)asynchronouslySetFontName:(NSString *)fontName success:(void(^)(NSString *name))success;
/**
 *  10号字体
 */
+ (UIFont *)fontTen;
/**
 *  11号字体
 */
+ (UIFont *)fontEleven;
/**
 *  12号字体
 */
+ (UIFont *)fontTwelve;
/**
 *  13号字体
 */
+ (UIFont *)fontThirteen;
/**
 *  14号字体
 */
+ (UIFont *)fontFourteen;
/**
 *  15号字体
 */
+ (UIFont *)fontFifteen;
/**
 *  16号字体
 */
+ (UIFont *)fontSixteen;
/**
 *  17号字体
 */
+ (UIFont *)fontSeventeen;
/**
 *  18号字体
 */
+ (UIFont *)fontEighteen;
/**
 *  19号字体
 */
+ (UIFont *)fontNineteen;
/**
 *  20号字体
 */
+ (UIFont *)fontTwenty;

@end
