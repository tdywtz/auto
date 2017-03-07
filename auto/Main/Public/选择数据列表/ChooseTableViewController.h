//
//  ChooseTableViewController.h
//  chezhiwang
//
//  Created by bangong on 16/12/16.
//  Copyright © 2016年 车质网. All rights reserved.
//

#import "BasicViewController.h"
#import "ChooseTableView.h"

#pragma mark - 列表
@interface ChooseTableViewController : BasicViewController

@property (nonatomic, strong) NSArray <__kindof ChooseTableViewSectionModel *> *sectionModels;
@property (nonatomic, assign) BOOL isShowSection;//显示sectionView
@property (nonatomic, assign) BOOL isIndex;//使用索引
@property (nonatomic, assign) BOOL isShowImage;//cell显示图片
@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, strong) NSArray<NSString *> *selectId;//已经选择的数据id

@property (nonatomic,copy)  didSelectedRow selectBlock;

- (void)reloadData;
- (instancetype)initWithStyle:(UITableViewStyle)style;

- (void)setBlock:(didSelectedRow)boock;


@end
