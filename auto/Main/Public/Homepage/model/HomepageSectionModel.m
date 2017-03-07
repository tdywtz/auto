//
//  HomepageSectionModel.m
//  chezhiwang
//
//  Created by bangong on 16/9/29.
//  Copyright © 2016年 车质网. All rights reserved.
//

#import "HomepageSectionModel.h"


@implementation HomepageSectionModel

- (NSMutableArray *)rowModels{
    if (_rowModels == nil) {
        _rowModels = [[NSMutableArray alloc] init];
    }
    return _rowModels;
}

@end
