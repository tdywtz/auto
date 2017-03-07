//
//  LHPhotosController.h
//  photos
//
//  Created by bangong on 16/1/18.
//  Copyright © 2016年 auto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

/**
 *  图片选择
 */
@interface LHPhotosNavigationController : UINavigationController

@property (nonatomic,assign) NSInteger maxNumber;
@property (nonatomic,copy) void(^photos)(NSArray <__kindof PHAsset*> *assets);

-(void)resultPhotos:(void(^)(NSArray <__kindof PHAsset*> *assets))block;

@end
