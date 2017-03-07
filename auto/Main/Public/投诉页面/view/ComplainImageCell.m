//
//  ComplainImageCell.m
//  chezhiwang
//
//  Created by bangong on 16/11/10.
//  Copyright © 2016年 车质网. All rights reserved.
//

#import "ComplainImageCell.h"
#import "ComplainSectionModel.h"
#import "LHPhotosNavigationController.h"
#import "ImageEditViewController.h"

@protocol ComplainShowImageViewDelegate <NSObject>

- (void)addClick;
- (void)tapAction:(NSInteger)index;

@end

@interface ComplainShowImageView : UIView
{
    UIButton *addButton;
    NSArray *imageViews;
    NSArray *_images;
}
@property (nonatomic, weak) id <ComplainShowImageViewDelegate> delegate;
@end

@implementation ComplainShowImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableArray *arr = [NSMutableArray array];
        CGFloat space = 5;
        CGFloat width = (frame.size.width - space * 2)/3;
        for (int i = 0; i < 6;  i++) {
            CGRect rect = CGRectMake(i%3*(width + space), i/3*(width + space), width, width);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.layer.masksToBounds = YES;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
            imageView.hidden = YES;

            [self addSubview:imageView];
            [arr addObject:imageView];
        }
        imageViews = arr;

        addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.layer.borderWidth = 1;
        addButton.layer.borderColor = colorLineGray.CGColor;
        [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];

        UIView *view = imageViews[0];
        addButton.frame = view.frame;
        self.lh_bottom = addButton.lh_bottom;

        UIView *vertical = [UIView new];
        vertical.backgroundColor = colorLineGray;

        UIView *horizontal = [UIView new];
        horizontal.backgroundColor = colorLineGray;

        [addButton addSubview:vertical];
        [addButton addSubview:horizontal];

        vertical.lh_size = CGSizeMake(2, 30);
        vertical.lh_centerX = addButton.lh_width/2;
        vertical.lh_centerY = addButton.lh_height/2;

        horizontal.lh_size = CGSizeMake(30, 2);
        horizontal.center = vertical.center;
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)tap{
    [self.delegate tapAction:[imageViews indexOfObject:tap.view]];
}

- (void)addClick{
    [self.delegate addClick];
}

- (CGFloat)getHeight{
    NSInteger index = 0;
    if (_images.count > 2) {
        index = 2;
    }
    UIView *view = imageViews[index];
    return view.lh_height;
}

- (void)setImages:(NSArray *)images{
    _images = images;
    NSInteger count = 0;
    for (int i = 0 ; i < imageViews.count; i ++) {
        UIImageView *imageView = imageViews[i];
        if (i < images.count) {
            imageView.image = images[i];
            imageView.hidden = NO;
            count ++;
           
        }else{
            imageView.hidden = YES;
            imageView.image = nil;
        }
    }

    if (count < 6) {
        addButton.hidden = NO;
        UIImageView *view = imageViews[count];
        addButton.frame = view.frame;
        self.lh_height = view.lh_bottom;
    }else{
        UIImageView *view = imageViews[5];
        self.lh_height = view.lh_bottom;
        addButton.hidden = YES;
    }
}
@end



@interface ComplainImageCell ()<ComplainShowImageViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ComplainImageCell
{
    UILabel *nameLabel;
    ComplainShowImageView *showImageView;
    UIImagePickerController *myPicker;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self makeUI];
    }

    return self;
}

- (void)makeUI{
    nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = colorBlack;
    nameLabel.font = [UIFont systemFontOfSize:15];

    showImageView = [[ComplainShowImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 110, 100)];
    showImageView.delegate = self;
    showImageView.backgroundColor = [UIColor clearColor];

    [self.contentView addSubview:nameLabel];
    [self.contentView addSubview:showImageView];
}

- (void)resetLayout{
    nameLabel.lh_left = 10;
    nameLabel.lh_centerY = 43;
    nameLabel.lh_size = CGSizeMake(70, 30);

    showImageView.lh_left = 100;
    showImageView.lh_top = 15;
    showImageView.lh_width = WIDTH-110;
}


- (void)setImageModel:(ComplainImageModel *)imageModel{
    _imageModel = imageModel;
    nameLabel.text = imageModel.name;
    [showImageView setImages:imageModel.imageArray];

    [self resetLayout];
}

#pragma mark - ComplainShowImageViewDelegate
- (void)tapAction:(NSInteger)index{
     __weak __typeof(self)weakSelf = self;
    ImageEditViewController *edit = [[ImageEditViewController alloc]  init];
    [edit setImageArray:_imageModel.imageArray showIndex:index];
    [edit setUpdateArray:^(NSArray *array) {
        weakSelf.imageModel.imageArray = array;
        [weakSelf.delegate updateCellheight];
    }];
    [self.parentVC.navigationController pushViewController:edit animated:YES];
}

- (void)addClick{

    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imageChoose];
    }];

    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (myPicker == nil) {
            myPicker = [[UIImagePickerController alloc] init];
            myPicker.delegate = self;
        }
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            myPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.parentVC presentViewController:myPicker animated:YES completion:nil];
        }

    }];

    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];

    [ac addAction:action2];
    [ac addAction:action];
    [ac addAction:action3];

    [self.parentVC presentViewController:ac animated:YES completion:nil];
}

- (void)imageChoose{
    LHPhotosNavigationController *vc = [[LHPhotosNavigationController alloc] init];
    vc.maxNumber = 6 - self.imageModel.imageArray.count;
    [vc resultPhotos:^(NSArray<__kindof PHAsset *> *assets) {
        __block NSInteger count = 0;
        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.imageModel.imageArray];
        for (PHAsset *asset in assets) {
            PHImageRequestOptions* requestOptions = [[PHImageRequestOptions alloc] init];
            requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
            requestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;

            //   PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
            [[PHImageManager defaultManager] requestImageForAsset:asset
                                                       targetSize:CGSizeMake(WIDTH, HEIGHT)
                                                      contentMode:PHImageContentModeAspectFit
                                                          options:requestOptions
                                                    resultHandler:^(UIImage *result, NSDictionary *info) {
                                                        count ++;
                                                        [arr addObject:result];
                                                        if (count == assets.count) {
                                                            self.imageModel.imageArray = arr;
                                                            [self.delegate updateCellheight];
                                                        }
                                                    }];
        }
    }];
    [self.parentVC presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 选择照片代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    if (self.imageModel.imageArray.count < 6) {

        NSMutableArray *arr = [self.imageModel.imageArray mutableCopy];
        if (arr == nil) {
            arr = [NSMutableArray array];
        }
        [arr addObject:image];
        self.imageModel.imageArray = arr;
        [self.delegate updateCellheight];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.parentVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
