//
//  LHPhotosCollectionViewCell.m
//  photos
//
//  Created by bangong on 16/1/21.
//  Copyright © 2016年 auto. All rights reserved.
//

#define  LHPhotosBundleName(name) [@"LHPhotos.bundle" stringByAppendingPathComponent:name]

#import "LHPhotosCollectionViewCell.h"
#import "PHAsset+LHPhotos.h"
#import "LHPhotosViewController.h"
#import "LHPhotosPageViewController.h"


@interface LHPhotosCollectionViewCell ()
{
  
    UIImageView *selectIamgeView;
}

@end

@implementation LHPhotosCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        [self.contentView addSubview:_imageView];
       
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];

        selectIamgeView = [[UIImageView alloc] init];
        [_imageView addSubview:selectIamgeView];
       
        selectIamgeView.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[selectIamgeView(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(selectIamgeView)]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[selectIamgeView(30)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(selectIamgeView)]];
        self.selected = NO;
      
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGetsture:)]];
    }
    return self;
}

- (void)longGetsture:(UIGestureRecognizer *)getsture{
    if (getsture.state == UIGestureRecognizerStateBegan) {
  

        PHImageRequestOptions* requestOptions = [[PHImageRequestOptions alloc] init];
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        requestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;

        [[PHImageManager defaultManager] requestImageForAsset:_asset
                                                   targetSize:[UIScreen mainScreen].bounds.size
                                                  contentMode:PHImageContentModeAspectFit
                                                      options:requestOptions
                                                resultHandler:^(UIImage *result, NSDictionary *info) {

                                                    LHPhotosPageViewController *vc = [LHPhotosPageViewController initWithSpace:15];
                                                    vc.assets = self.parentViewController.assets;
                                                    [vc setAsset:_asset image:result];

                                                    vc.pageIndex = [self.parentViewController.assets indexOfObject:self.asset];
                                                    vc.selectAssets = self.selectAssets;
                                                    [self.parentViewController.navigationController pushViewController:vc animated:YES];

                                                }];

    }
}

- (void)setParentViewController:(LHPhotosViewController *)parentViewController{
    _parentViewController = parentViewController;

}



-(void)setAsset:(PHAsset *)asset{
    if (_asset == asset) {
        return;
    }
    _asset = asset;
   
    if (_asset.assetSelected) {
        selectIamgeView.image = [UIImage imageNamed:LHPhotosBundleName(@"FriendsSendsPicturesSelectBigYIcon")];
    }else{
        selectIamgeView.image = [UIImage imageNamed:LHPhotosBundleName(@"FriendsSendsPicturesSelectBigNIcon")];
    }
    
  
        PHImageRequestOptions* requestOptions = [[PHImageRequestOptions alloc] init];
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        requestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
        
     //   PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
        [[PHImageManager defaultManager] requestImageForAsset:_asset
                                targetSize:CGSizeMake(200, 200)
                               contentMode:PHImageContentModeAspectFill
                                   options:requestOptions
                             resultHandler:^(UIImage *result, NSDictionary *info) {
                                 
                                 _imageView.image = result;
                          
                             }];
  
}



@end
