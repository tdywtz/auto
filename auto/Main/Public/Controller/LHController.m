//
//  LHController.m
//  auto
//
//  Created by bangong on 15/7/3.
//  Copyright (c) 2015年 车质网. All rights reserved.
//

#import "LHController.h"

@implementation LHController



#pragma mark - UITextView
+(UITextField *)createTextFieldWithFrame:(CGRect)frame andBGImageName:(NSString *)name andPlaceholder:(NSString *)placeholder andTextFont:(CGFloat)size andSmallImageName:(NSString *)smallName andDelegate:(id)delegate{

    UIImage *imge = [UIImage imageNamed:name];
    imge = [imge stretchableImageWithLeftCapWidth:8 topCapHeight:5];

    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    [textField setBackground:imge];
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:size-3];
    //清除按钮
    textField.clearButtonMode=YES;
    //关闭首字母大写
    textField.autocapitalizationType=NO;
    
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, frame.size.height)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
    
    
    if (smallName) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-18, 4, 11, frame.size.height-8)];
        image.image =[UIImage imageNamed:smallName];
        [textField addSubview:image];
    }
    
    if (delegate) {
        textField.delegate = delegate;
    }
    textField.backgroundColor = [UIColor whiteColor];
    return textField;
}

+(UITextField *)createTextFieldWithFrame:(CGRect)frame Placeholder:(NSString *)placeholder Font:(CGFloat)font Delegate:(id)delegate{

    
    UITextField *field = [[UITextField alloc] initWithFrame:frame];
    field.placeholder = placeholder;
    field.font = [UIFont systemFontOfSize:font-3];
    field.clearButtonMode = YES;
    field.textColor = colorBlack;
    //关闭首字母大写
    field.autocapitalizationType=NO;
    if (delegate) {
        field.delegate = delegate;
    }
    
   // UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, frame.size.height)];
    field.leftViewMode = UITextFieldViewModeAlways;
   // field.leftView = leftview;

    return field;
}

+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    //灰色提示框
    textField.placeholder=placeholder;
    //文字对齐方式
    textField.textAlignment=NSTextAlignmentLeft;
    textField.secureTextEntry=YESorNO;
    //边框
    //textField.borderStyle=UITextBorderStyleLine;
    //键盘类型
    textField.keyboardType=UIKeyboardTypeEmailAddress;
    //关闭首字母大写
    textField.autocapitalizationType=NO;
    //清除按钮
    textField.clearButtonMode=YES;
    //左图片
    textField.leftView=imageView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    //右图片
    textField.rightView=rightImageView;
    //编辑状态下一直存在
    textField.rightViewMode=UITextFieldViewModeWhileEditing;
    //自定义键盘
    //textField.inputView
    //字体
    textField.font=[UIFont systemFontOfSize:font];
    //字体颜色
    textField.textColor=[UIColor blackColor];
    return textField ;
}


#pragma mark - 判断字符串是否为空
+(BOOL)judegmentSpaceChar:(NSString *)str{
    NSArray *array = [str componentsSeparatedByString:@" "];
    for (NSString *string in array) {
        if (string.length > 0) return YES;
    }
    return NO;
}

#pragma mark - 判断字符串中是否只有汉字、字母。数字
+(BOOL)judegmentChar:(NSString *)str{
//    for (int i = 0; i < str.length; i ++) {
//    
//        unichar c = [str characterAtIndex:i];
//      //const  char *han = [[str substringFromIndex:i] UTF8String];
//        if (!(c > 0x4e00 && c < 0x9fff)) {
//            if (!(c >= '0' && c <= '9')) {
//                if (!((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'))) {
//                      return NO;
//                }
//              
//            }
//        }
//   
//    }
//    return YES;
    NSString * regex = @"^[\u4e00-\u9fa5A-Za-z0-9\u3000-\u301e\ufe10-\ufe19\ufe30-\ufe44\ufe50-\ufe6b\uff01-\uffee]{0,25}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

#pragma mark - 判断字符串中是否只有字母。数字
+(BOOL)judegmentCarNum:(NSString *)str{
    for (int i = 0; i < str.length; i ++) {
        
        unichar c = [str characterAtIndex:i];
        if (!isdigit(c) && !isalpha(c)) {
            return NO;
        }
     
    }
    return YES;
}




#pragma mark - 黄色背景圆角按钮
+(UIButton *)createButtnFram:(CGRect)frame Target:(id)target Action:(SEL)action Font:(CGFloat)font Text:(NSString *)text{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = frame;
    btn.backgroundColor = [UIColor colorWithRed:254/255.0 green:153/255.0 blue:23/255.0 alpha:1];
    btn.layer.cornerRadius = 3;
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:font];
    btn.layer.masksToBounds = YES;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

#pragma mark - 自定义按钮
+(UIButton *)createButtnFram:(CGRect)frame Target:(id)target Action:(SEL)action Text:(NSString *)text{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

#pragma mark --创建Label
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(CGFloat)font Bold:(BOOL)bold TextColor:(UIColor *)color Text:(NSString*)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    if (color) {
        label.textColor = color;
    }
    if (bold == YES) {
        label.font = [UIFont boldSystemFontOfSize:font];
    }
    label.numberOfLines = 0;
    return label;
}

+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text
{
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    //限制行数
    label.numberOfLines=0;
    //对齐方式
    label.textAlignment=NSTextAlignmentLeft;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:font];
    //单词折行
    label.lineBreakMode=NSLineBreakByWordWrapping;
    //默认字体颜色是白色
    label.textColor=[UIColor blackColor];
    //自适应（行数~字体大小按照设置大小进行设置）
    label.adjustsFontSizeToFitWidth=YES;
    label.text=text;
    return label;
}

#define mark - 创建图片控制器
+(UIImageView *)createImageViewWithFrame:(CGRect)frame ImageName:(NSString *)name{
    UIImageView *iamgeView = [[UIImageView alloc] initWithFrame:frame];
    iamgeView.image = [UIImage imageNamed:name];
    return iamgeView;
}


#pragma mark - 邮箱格式验证
+(BOOL)emailTest:(NSString *)email{

    
    if (![email hasSuffix:@".com"] && ![email hasSuffix:@".cn"]) {
        return NO;
    }
    NSArray *aray = [email componentsSeparatedByString:@"@"];
    if (aray.count != 2) {
        return NO;
    }
   
    return YES;
}


#pragma mark - 判断输入文字是否含有表情字符
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

@end
