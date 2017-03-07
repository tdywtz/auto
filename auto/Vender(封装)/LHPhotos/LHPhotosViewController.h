//
//  LHPhotosGroupViewController.h
//  photos
//
//  Created by bangong on 16/1/18.
//  Copyright © 2016年 auto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
/**
 *  相册
 */
@interface LHPhotosViewController : UIViewController

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong)  PHAssetCollection *assetCollection;
@property (nonatomic,strong) NSMutableArray<__kindof PHAsset *> *assets;

@end
