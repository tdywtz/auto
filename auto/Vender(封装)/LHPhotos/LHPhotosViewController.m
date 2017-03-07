//
//  LHPhotosGroupViewController.m
//  photos
//
//  Created by bangong on 16/1/18.
//  Copyright © 2016年 auto. All rights reserved.
//

#import "LHPhotosViewController.h"
#import "LHPhotosCollectionViewCell.h"
#import "LHPhotosNavigationController.h"
#import  "PHAsset+LHPhotos.h"

#define  IDENTIFIER @"collectionCell"


@interface LHPhotosViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,PHAssetDelegate>


@property (nonatomic,strong) NSMutableArray <__kindof PHAsset *>*selectAssets;

@end

@implementation LHPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self createRightItem];
    [self createCollectionView];
    [self setGroup];
    
}

-(void)createRightItem{
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
}

-(void)rightItemClick{
    LHPhotosNavigationController *contro = (LHPhotosNavigationController *)self.navigationController;

    if (contro.photos) {
       contro.photos(self.selectAssets);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:_collectionView];
    
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView)]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView)]];
    
    
    [_collectionView registerClass:[LHPhotosCollectionViewCell class] forCellWithReuseIdentifier:IDENTIFIER];
}

-(void)setGroup{
    
    if (self.assets) {
        [self.assets removeAllObjects];
    }else{
        self.assets = [[NSMutableArray alloc] init];
    }
   
    if (!self.selectAssets) {
        self.selectAssets = [[NSMutableArray alloc] init];
    }

    PHFetchResult *fet = [PHAsset fetchAssetsInAssetCollection:self.assetCollection options:nil];
    [fet enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.assets addObject:obj];
    }];
    [_collectionView reloadData];
}

#pragma mark - PHAssetDelegate
- (void)assetDidChangeValueForKey:(NSString *)key asset:(PHAsset *)asset{
    NSInteger row = [self.assets indexOfObject:asset];
    if (row == NSNotFound) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:0];
     [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];

    if (asset.assetSelected) {
        [self.selectAssets addObject:asset];
    }else{
        [self.selectAssets removeObject:asset];
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHPhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER forIndexPath:indexPath];
    cell.asset = self.assets[indexPath.row];
    cell.asset.delegate = self;
    cell.parentViewController = self;
    cell.selectAssets = self.selectAssets;
   
    return cell;
}


#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LHPhotosNavigationController *poto = (LHPhotosNavigationController *)self.navigationController;
    
    PHAsset *asset = self.assets[indexPath.row];
    if (asset.assetSelected == NO && self.selectAssets.count >= poto.maxNumber) {
        return;
    }
    asset.assetSelected = !asset.assetSelected;
  
}

#pragma mark - UICollectionViewDelegateFlowLayout <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    return CGSizeMake(self.view.frame.size.width/4-2, self.view.frame.size.width/4-2);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 10, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
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

