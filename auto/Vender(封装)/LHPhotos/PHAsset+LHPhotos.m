//
//  PHAsset+LHPhotos.m
//  Photos
//
//  Created by bangong on 16/6/7.
//  Copyright © 2016年 auto. All rights reserved.
//

#import "PHAsset+LHPhotos.h"
#import <objc/runtime.h>

@implementation PHAsset (LHPhotos)

- (void)didChangeValueForKey:(NSString *)key{
    if ([self.delegate respondsToSelector:@selector(assetDidChangeValueForKey:asset:)]) {
        [self.delegate assetDidChangeValueForKey:key asset:self];
    }
}

- (void)setDelegate:(id<PHAssetDelegate>)delegate{
    objc_setAssociatedObject(self, @"delegate", delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<PHAssetDelegate>)delegate{
     return  objc_getAssociatedObject(self, @"delegate");
}

char *const ASSETSELECTED = "ASSETSELECTED";

- (void)setAssetSelected:(BOOL)assetSelected{
    [self willChangeValueForKey:[NSString stringWithUTF8String:ASSETSELECTED]];
    objc_setAssociatedObject(self, ASSETSELECTED, [NSNumber numberWithBool:assetSelected], OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:[NSString stringWithUTF8String:ASSETSELECTED]];
}

-(BOOL)assetSelected{
   return  [objc_getAssociatedObject(self, ASSETSELECTED) boolValue];
}



@end
