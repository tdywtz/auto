//
//  ImageEditViewController.h
//  auto
//
//  Created by bangong on 17/2/21.
//  Copyright © 2017年 车质网. All rights reserved.
//

#import "BasicViewController.h"

@interface ImageEditViewController : BasicViewController

@property (nonatomic, copy) void (^updateArray)(NSArray *array);

- (void)setImageArray:(NSArray *)imageArray showIndex:(NSInteger)index;



@end
