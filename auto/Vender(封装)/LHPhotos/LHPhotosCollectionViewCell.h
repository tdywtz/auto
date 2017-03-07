//
//  LHPhotosCollectionViewCell.h
//  photos
//
//  Created by bangong on 16/1/21.
//  Copyright © 2016年 auto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@class LHPhotosViewController;

@interface LHPhotosCollectionViewCell : UICollectionViewCell

@property (nonatomic,weak) LHPhotosViewController *parentViewController;
@property (nonatomic,weak) NSMutableArray *selectAssets;

@property (nonatomic,strong) PHAsset *asset;
@property (nonatomic,strong)   UIImageView *imageView;

@end
