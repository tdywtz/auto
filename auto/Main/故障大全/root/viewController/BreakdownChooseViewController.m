//
//  BreakdownChooseViewController.m
//  auto
//
//  Created by bangong on 17/2/14.
//  Copyright © 2017年 车质网. All rights reserved.
//

#import "BreakdownChooseViewController.h"
#import "ResultViewController.h"


#pragma mark - BreakdownChooseItemModel
@interface BreakdownChooseItemModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;

+ (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName;

@end

@implementation BreakdownChooseItemModel

+ (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName{
    BreakdownChooseItemModel *model = [[BreakdownChooseItemModel alloc] init];
    model.title = title;
    model.imageName = imageName;
    return model;
}

@end


#pragma mark - BreakdownChooseSectionModel
@interface BreakdownChooseSectionModel : NSObject

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<BreakdownChooseItemModel *> *itemMdoels;

- (void)resetIdnex;
@end

@implementation BreakdownChooseSectionModel

- (void)resetIdnex{
    _index = - 1;
}
@end


#pragma mark - BreakdownChooseViewCell
@interface BreakdownChooseViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BreakdownChooseViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        _titleLabel = [UILabel new];
        _titleLabel.textColor = colorBlack;
        _titleLabel.font = [UIFont systemFontOfSize:15];

        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeCenter;

        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_imageView];
        [self textOnly:YES];
    }
    return self;
}



- (void)textOnly:(BOOL)text{
    if (!text) {
        _imageView.hidden = NO;
        _titleLabel.textAlignment = NSTextAlignmentLeft;

        _imageView.lh_left = 3;
        _imageView.lh_top = 0;
        _imageView.lh_height = self.contentView.lh_height;
        _imageView.lh_width = 35;

        _titleLabel.lh_left = _imageView.lh_right + 5;
        _titleLabel.lh_top  = 0;
        _titleLabel.lh_height = self.lh_height;
        _titleLabel.lh_width = self.lh_width - _titleLabel.lh_left;
    }else{
        _imageView.hidden = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;

        _titleLabel.lh_left = 0;
        _titleLabel.lh_top  = 0;
        _titleLabel.lh_height = self.lh_height;
        _titleLabel.lh_width = self.lh_width;
    }
}
@end

#pragma mark - BreakdownChooseHeaderSectionView
@interface BreakdownChooseHeaderSectionView : UICollectionReusableView

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BreakdownChooseHeaderSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = colorBackGround;

        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = colorBlack;

        [self addSubview:_titleLabel];

        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
    }
    return self;
}
@end

#pragma mark - BreakdownChooseViewController
static NSString *reuseIdentifier = @"cell";
static NSString *headerReuseIdentifier = @"headerReuseIdentifier";
static NSString *footReuseIdentifier = @"footReuseIdentifier";

@interface BreakdownChooseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
    NSArray *_dataArray;
}
@end

@implementation BreakdownChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   [self setData];
   [self createCollectionView];

   // [_collectionView reloadData];
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;

    _collectionView = [[UICollectionView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.view.frame, _contentInsets) collectionViewLayout:layout];
    _collectionView.backgroundColor = RGB_color(250, 250, 250, 1);
    _collectionView.delegate = self;
    _collectionView.dataSource  = self;
    [self.view addSubview:_collectionView];

    [_collectionView registerClass:[BreakdownChooseViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [_collectionView registerClass:[BreakdownChooseHeaderSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footReuseIdentifier];

}

- (void)setData{

    BreakdownChooseSectionModel *one = [BreakdownChooseSectionModel new];
    one.title = @"车型";
    [one resetIdnex];
    one.itemMdoels = @[
                       [BreakdownChooseItemModel initWithTitle:@"微车型" imageName:@"che1"],
                       [BreakdownChooseItemModel initWithTitle:@"小车型" imageName:@"che2"],
                       [BreakdownChooseItemModel initWithTitle:@"紧凑型车" imageName:@"che3"],
                       [BreakdownChooseItemModel initWithTitle:@"中型车" imageName:@"che4"],
                       [BreakdownChooseItemModel initWithTitle:@"中大型车" imageName:@"che5"],
                       [BreakdownChooseItemModel initWithTitle:@"豪华型车" imageName:@"che6"],
                       [BreakdownChooseItemModel initWithTitle:@"SUV" imageName:@"che7"],
                       [BreakdownChooseItemModel initWithTitle:@"MPV" imageName:@"che8"],
                       [BreakdownChooseItemModel initWithTitle:@"跑车" imageName:@"che9"],
                       [BreakdownChooseItemModel initWithTitle:@"面包车" imageName:@"che10"],
                       [BreakdownChooseItemModel initWithTitle:@"其他" imageName:@"che11"],
                       [BreakdownChooseItemModel initWithTitle:@"电动车" imageName:@"che12"]
                       ];

    BreakdownChooseSectionModel *two = [BreakdownChooseSectionModel new];
    two.title = @"国别";
    [two resetIdnex];
    two.itemMdoels =  @[
                        [BreakdownChooseItemModel initWithTitle:@"中国" imageName:@"flag1"],
                        [BreakdownChooseItemModel initWithTitle:@"德国" imageName:@"flag2"],
                        [BreakdownChooseItemModel initWithTitle:@"美国" imageName:@"flag3"],
                        [BreakdownChooseItemModel initWithTitle:@"日本" imageName:@"flag4"],
                        [BreakdownChooseItemModel initWithTitle:@"韩国" imageName:@"flag5"],
                        [BreakdownChooseItemModel initWithTitle:@"法国" imageName:@"flag6"],
                        [BreakdownChooseItemModel initWithTitle:@"欧系" imageName:@"flag7"]
                        ];

    BreakdownChooseSectionModel *three = [BreakdownChooseSectionModel new];
    three.title = @"八大系统";
    [three resetIdnex];
    three.itemMdoels =  @[
                          [BreakdownChooseItemModel initWithTitle:@"发动机" imageName:@"system1"],
                          [BreakdownChooseItemModel initWithTitle:@"变速器" imageName:@"system2"],
                          [BreakdownChooseItemModel initWithTitle:@"离合器" imageName:@"system3"],
                          [BreakdownChooseItemModel initWithTitle:@"转向系统" imageName:@"system4"],
                          [BreakdownChooseItemModel initWithTitle:@"制动系统" imageName:@"system5"],
                          [BreakdownChooseItemModel initWithTitle:@"轮胎" imageName:@"system6"],
                          [BreakdownChooseItemModel initWithTitle:@"前后桥及悬挂系统" imageName:@"system7"],
                          [BreakdownChooseItemModel initWithTitle:@"车身附件及电器" imageName:@"system8"]
                          ];

    BreakdownChooseSectionModel *four = [BreakdownChooseSectionModel new];
    four.title = @"出故障时间";
    [four resetIdnex];
    four.itemMdoels =  @[
                         [BreakdownChooseItemModel initWithTitle:@"1个月" imageName:nil],
                         [BreakdownChooseItemModel initWithTitle:@"1-3个月" imageName:nil],
                         [BreakdownChooseItemModel initWithTitle:@"3-5个月" imageName:nil],
                         [BreakdownChooseItemModel initWithTitle:@"6-12个月" imageName:nil],
                         [BreakdownChooseItemModel initWithTitle:@"1-3年" imageName:nil],
                         [BreakdownChooseItemModel initWithTitle:@"3年以上" imageName:nil]
                         ];

    _dataArray = @[one,two,three,four];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return _dataArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    BreakdownChooseSectionModel *sectionModel = _dataArray[section];
    return sectionModel.itemMdoels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BreakdownChooseViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    BreakdownChooseSectionModel *sectionModel = _dataArray[indexPath.section];
    BreakdownChooseItemModel *model = sectionModel.itemMdoels[indexPath.row];
    if (indexPath.row == sectionModel.index) {
        cell.contentView.layer.borderWidth = 1;
        cell.contentView.layer.borderColor = colorLightBlue.CGColor;
    }else{
        cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    }
    if (model.imageName) {
        cell.imageView.image = [UIImage imageNamed:model.imageName];
    }
    cell.titleLabel.text = model.title;
    if (indexPath.section == 3) {
        [cell textOnly:YES];
    }else{
        [cell textOnly:NO];
    }
    // Configure the cell

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BreakdownChooseHeaderSectionView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
        BreakdownChooseSectionModel *sectionModel = _dataArray[indexPath.section];
        headerView.titleLabel.text = sectionModel.title;
        return headerView;
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        if (indexPath.section != 3) {
            return nil;
        }
        UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footReuseIdentifier forIndexPath:indexPath];
        UIButton *btn = [foot viewWithTag:100];
        if (btn == nil) {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"auto_common_search"] forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, -10)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            [btn setTitle:@"搜索" forState:UIControlStateNormal];
            btn.backgroundColor = colorYellow;
            btn.layer.cornerRadius = 3;
            btn.layer.masksToBounds = YES;
            btn.tag = 100;
            [btn addTarget:self action:@selector(serachClick) forControlEvents:UIControlEventTouchUpInside];
            [foot addSubview:btn];
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(CGSizeMake(WIDTH- 20, 40));
                make.centerX.equalTo(CGPointZero);
                make.top.equalTo(10);
            }];
        }

        return foot;
    }
    return nil;
}

- (void)serachClick{
    BreakdownChooseSectionModel *model = _dataArray[0];
    NSString *att = model.index >= 0 ? [NSString stringWithFormat:@"%ld",model.index + 1] : nil;
    model = _dataArray[1];
    NSString *place = model.index >= 0 ? [NSString stringWithFormat:@"%ld",model.index + 1] : nil;
    model = _dataArray[2];
    NSString *sys = model.index >= 0 ? [NSString stringWithFormat:@"%ld",model.index + 1] : nil;
    model = _dataArray[3];
    NSString *time = model.index >= 0 ? [NSString stringWithFormat:@"%ld",model.index + 1] : nil;


    ResultViewController *result = [[ResultViewController alloc] init];
    result.att = att;
    result.place = place;
    result.sys = sys;
    result.time = time;
    result.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:result animated:YES];
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BreakdownChooseSectionModel *sectionModel = _dataArray[indexPath.section];

    if (sectionModel.index == indexPath.row) {
        [sectionModel resetIdnex];
    }else{
        sectionModel.index = indexPath.row;
    }
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && indexPath.row > 5) {
        return CGSizeMake((WIDTH - 20)/2 - 5, 40);
    }
    return CGSizeMake((WIDTH - 40)/3, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 9;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(WIDTH, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return CGSizeMake(WIDTH, 70);
    }
    return CGSizeZero;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
