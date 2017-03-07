//
//  BasicNavigationController.h
//  12365auto
//
//  Created by bangong on 16/3/21.
//  Copyright © 2016年 车质网. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicNavigationController : UINavigationController

@property(nonatomic, strong) UIView *alphaView;

- (void)popViewController;

@end
