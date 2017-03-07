//
//  LHController.h
//  auto
//
//  Created by bangong on 15/7/3.
//  Copyright (c) 2015年 车质网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomTabBarController.h"


@interface LHController : NSObject

#pragma mark - UITextView
+(UITextField *)createTextFieldWithFrame:(CGRect)frame andBGImageName:(NSString *)name andPlaceholder:(NSString *)placeholder andTextFont:(CGFloat)size andSmallImageName:(NSString *)smallName andDelegate:(id)delegate;
+(UITextField *)createTextFieldWithFrame:(CGRect)frame Placeholder:(NSString *)placeholder Font:(CGFloat)font  Delegate:(id)delegate;
//+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font;

#pragma mark - 判断字符串是否为空
+(BOOL)judegmentSpaceChar:(NSString *)str;
#pragma mark - 判断字符串中是否只有汉字、字母。数字
+(BOOL)judegmentChar:(NSString *)str;
#pragma mark - 判断字符串中是否只有字母。数字
+(BOOL)judegmentCarNum:(NSString *)str;


#pragma mark - 黄色背景圆角按钮
+(UIButton *)createButtnFram:(CGRect)frame Target:(id)target Action:(SEL)action Font:(CGFloat)font Text:(NSString *)text;
/**自定义按钮*/
+(UIButton *)createButtnFram:(CGRect)frame Target:(id)target Action:(SEL)action Text:(NSString *)text;

#pragma mark --创建Label
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(CGFloat)font Bold:(BOOL)bold TextColor:(UIColor *)
color Text:(NSString*)text;
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text;

#define mark - 创建图片控制器
+(UIImageView *)createImageViewWithFrame:(CGRect)frame ImageName:(NSString *)name;
#pragma mark - 邮箱格式验证
+(BOOL)emailTest:(NSString *)email;

@end
