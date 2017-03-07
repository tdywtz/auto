//
//  LHPhotosGroupsViewController.m
//  photos
//
//  Created by bangong on 16/3/7.
//  Copyright © 2016年 auto. All rights reserved.
//

#import "LHPhotosGroupsViewController.h"
#import <Photos/Photos.h>
#import "LHPhotosViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface LHGroupsCell : UITableViewCell

@end

@implementation LHGroupsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }

    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(5, 3, self.frame.size.height-6, self.frame.size.height-6);

    CGRect rect1 = self.textLabel.frame;
    rect1.origin.x = self.imageView.frame.size.width+10;
    self.textLabel.frame = rect1;

    CGRect rect2 = self.detailTextLabel.frame;
    rect2.origin.x = rect1.origin.x;
    self.detailTextLabel.frame = rect2;
}

@end

#pragma mark - //////////////////////////////////////////////// \

@interface LHPhotosGroupsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation LHPhotosGroupsViewController

- (instancetype)init{
    if (self = [super init]) {

        _dataArray = [[NSMutableArray alloc] init];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];

    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 65, 0, 0);
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];

    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {

            dispatch_sync(dispatch_get_main_queue(), ^{
                [self readPhotos];
            });

        }else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self createPrompt];
            });
        }
    }];

    //[self enable];
}

- (void)readPhotos{

    // [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"groupsCell"];


    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    [assetCollections enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj) {
            [_dataArray addObject:obj];
        }
    }];

    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    // 遍历相机胶卷,获取大图
    if (cameraRoll) {
        [_dataArray addObject:cameraRoll];
    }

    [_tableView reloadData];
}

-(void)rightItemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createPrompt{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"当前应用未获得使用相册授权，去设置？" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    [btn sizeToFit];
    btn.center = self.view.center;


}

//打开系统设置
-(void)btnClick{
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];

    if([[UIApplication sharedApplication] canOpenURL:url]) {

        [[UIApplication sharedApplication] openURL:url];

    }
}

-(BOOL)enable{
    BOOL enabel = YES;
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];

    if(authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied){
        NSLog(@"权限受限");
        enabel = NO;
        [self createPrompt];
    }else if (authStatus == PHAuthorizationStatusNotDetermined){

    }

    return enabel;
}

- (NSString *)transformAblumTitle:(NSString *)title
{
    if ([title isEqualToString:@"Slo-mo"]) {
        return @"慢动作";
    } else if ([title isEqualToString:@"Recently Added"]) {
        return @"最近添加";
    } else if ([title isEqualToString:@"Favorites"]) {
        return @"最爱";
    } else if ([title isEqualToString:@"Recently Deleted"]) {
        return @"最近删除";
    } else if ([title isEqualToString:@"Videos"]) {
        return @"视频";
    } else if ([title isEqualToString:@"All Photos"]) {
        return @"所有照片";
    } else if ([title isEqualToString:@"Selfies"]) {
        return @"自拍";
    } else if ([title isEqualToString:@"Screenshots"]) {
        return @"屏幕快照";
    } else if ([title isEqualToString:@"Camera Roll"]) {
        return @"相机胶卷";
    }
    return title;
}

//删除相册
- (void)deleteAssetCollections:(id<NSFastEnumeration>)assetCollections{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{

        [PHAssetCollectionChangeRequest deleteAssetCollections:assetCollections];

    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {

            for (PHAssetCollection *assetCollection in ((NSArray *)assetCollections)) {
                 [_dataArray removeObject:assetCollection];
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
               [_tableView reloadData];
            });

        }
    }];
}

///新建一个名字叫做title的相册
-(void)addCustomGroupWithTitle:(NSString *)title
             completionHandler:(void (^)(void))successBlock
                      failture:(void (^)(NSString * _Nonnull))failtureBlock
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{

        //创建一个创建相册的请求
        [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];

    }completionHandler:^(BOOL success, NSError * _Nullable error) {

        if (success == true)//成功
        {
            successBlock();return ;
        }
        //失败
        failtureBlock(error.localizedDescription);
    }];
}

///向collection中添加图片
-(void)addCustomAsset:(UIImage *)image
           collection:(PHAssetCollection *)collection
    completionHandler:(void (^)(void))successBlock
             failture:(void (^)(NSString * _Nonnull))failtureBlock
{
    //执行变化请求
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{

        //如果相册允许操作
        if([collection canPerformEditOperation:PHCollectionEditOperationAddContent])
        {
            //创建资源请求对象
            PHAssetChangeRequest * assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];

            //创建相册请求对象
            PHAssetCollectionChangeRequest * groupChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];

            //向相册中添加资源
            [groupChangeRequest addAssets:@[assetChangeRequest.placeholderForCreatedAsset]];

        }

    }completionHandler:^(BOOL success, NSError * _Nullable error) {

        if (success == true)//成功
        {
            successBlock();return;
        }
        //失败
        failtureBlock(error.localizedDescription);
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LHGroupsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupsCell"];
    if (!cell) {
        cell = [[LHGroupsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"groupsCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    PHAssetCollection *assetCollection = _dataArray[indexPath.row];
    cell.textLabel.text = [self transformAblumTitle:assetCollection.localizedTitle];


    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",assets.count];

    if (assets.count) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        options.resizeMode = PHImageRequestOptionsResizeModeExact;
        // 同步获得图片, 只会返回1张图片
        options.synchronous = YES;
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:assets[0] targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            cell.imageView.image = result;
            //  NSLog(@"%@",result);
        }];
    }else{
        [cell.imageView setContentMode:UIViewContentModeScaleToFill];
        cell.imageView.image = [UIImage imageNamed:@"default"];
    }


    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PHAssetCollection *assetCollection = _dataArray[indexPath.row];
    LHPhotosViewController *photos = [[LHPhotosViewController alloc] init];
    photos.title = assetCollection.localizedTitle;
    photos.assetCollection = assetCollection;
    [self.navigationController pushViewController:photos animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除相册" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        PHAssetCollection *assetCollection = _dataArray[indexPath.row];
        [self deleteAssetCollections:@[assetCollection]];
    }];
    return @[action];
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
