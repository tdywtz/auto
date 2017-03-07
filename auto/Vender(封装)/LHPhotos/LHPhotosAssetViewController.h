//
//  LHPhotosAssetViewController.h
//  Photos
//
//  Created by bangong on 16/6/21.
//  Copyright © 2016年 auto. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PHAsset;
/**
 *  展示大图
 */
@interface LHPhotosAssetViewController : UIViewController

@property (nonatomic,strong) PHAsset *asset;
@property (nonatomic,strong) UIImage *image;//展示动画使用
@property (nonatomic,strong) UIImageView *imageView;

@end
