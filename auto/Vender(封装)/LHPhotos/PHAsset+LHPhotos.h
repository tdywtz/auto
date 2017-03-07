//
//  PHAsset+LHPhotos.h
//  Photos
//
//  Created by bangong on 16/6/7.
//  Copyright © 2016年 auto. All rights reserved.
//

#import <Photos/Photos.h>

@protocol PHAssetDelegate <NSObject>

- (void)assetDidChangeValueForKey:(NSString *)key asset:(PHAsset *)asset;

@end

@interface PHAsset (LHPhotos)

@property (nonatomic,weak) id<PHAssetDelegate> delegate;
@property (nonatomic,assign) BOOL assetSelected;

@end
