//
//  LoginViewController.h
//  chezhiwang
//
//  Created by bangong on 15/11/13.
//  Copyright © 2015年 车质网. All rights reserved.
//

#import "BasicViewController.h"

@interface LoginViewController : BasicViewController

@property (nonatomic, copy) void(^success)();

+ (UINavigationController *)instanceSuccess:(void(^)())success;
@end
