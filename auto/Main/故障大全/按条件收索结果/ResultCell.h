//
//  ResultCell.h
//  auto
//
//  Created by bangong on 15/6/9.
//  Copyright (c) 2015年 车质网. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultModel.h"

@interface ResultCell : UITableViewCell

@property (nonatomic,strong) ResultModel *model;
@property (nonatomic,copy) NSString *system;
@end
