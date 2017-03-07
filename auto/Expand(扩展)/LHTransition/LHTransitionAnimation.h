//
//  LHTransitionAnimation.h
//  auto
//
//  Created by bangong on 17/2/27.
//  Copyright © 2017年 车质网. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>


@property (nonatomic, assign) UINavigationControllerOperation operation;

@end
