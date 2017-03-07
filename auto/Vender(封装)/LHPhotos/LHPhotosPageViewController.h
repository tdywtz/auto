//
//  LHPhotosPageViewController.h
//  Photos
//
//  Created by bangong on 16/6/21.
//  Copyright © 2016年 auto. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PHAsset;

@interface LHPhotosPageViewController : UIPageViewController


@property (nonatomic,strong) NSArray<__kindof PHAsset *> *assets;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,weak) NSMutableArray<__kindof PHAsset *> *selectAssets;

- (void)setAsset:(PHAsset *)asset image:(UIImage *)image;

+(instancetype)initWithSpace:(CGFloat)space;

@end
