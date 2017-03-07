//
//  ChooseTableView.h
//  chezhiwang
//
//  Created by bangong on 17/1/12.
//  Copyright © 2017年 车质网. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 模型
@class ChooseTableViewModel;

@interface ChooseTableViewSectionModel : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSArray <__kindof ChooseTableViewModel*> *rowModels;

+ (void)brand:(void(^)(NSArray <ChooseTableViewSectionModel *> *sectionModels))result;
+ (void)seriesWithBid:(NSString *)bid result:(void(^)(NSArray <ChooseTableViewSectionModel *> *sectionModels))result;
+ (void)modelWithSid:(NSString *)sid result:(void(^)(NSArray <ChooseTableViewSectionModel *> *sectionModels))result;


@end

@interface ChooseTableViewModel : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *imageUrl;

@end

#pragma mark - cell
@interface ChooseTableViewCell : UITableViewCell

- (void)setModel:(ChooseTableViewModel *)model;
@property (nonatomic,assign) BOOL isShowImage;

@end

#pragma mark - ChooseTableView

typedef void(^didSelectedRow)(ChooseTableViewModel *model);

@interface ChooseTableView : UIView

@property (nonatomic,strong) UITableView *tableView;
@property (assign,readonly)           UITableViewStyle style;

@property (nonatomic,strong) NSArray <__kindof ChooseTableViewSectionModel *> *sectionModels;
@property BOOL isShowSection;//显示sectionView
@property BOOL isIndex;//使用索引
@property (nonatomic,assign) BOOL isShowImage;//cell显示图片
@property (nonatomic, strong) NSArray<NSString *> *selectId;//已经选择的数据id

@property (nonatomic,copy) didSelectedRow selectBlock;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
