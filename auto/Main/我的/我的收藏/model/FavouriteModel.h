//
//  FavouriteModel.h
//  auto
//
//  Created by bangong on 17/2/23.
//  Copyright © 2017年 车质网. All rights reserved.
//

#import "JKDBModel.h"
//收藏
@interface FavouriteModel : JKDBModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) NewsType type;
@end
