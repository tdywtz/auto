//
//  LHPhotosPageViewController.m
//  Photos
//
//  Created by bangong on 16/6/21.
//  Copyright © 2016年 auto. All rights reserved.
//

#import "LHPhotosPageViewController.h"
#import "LHPhotosAssetViewController.h"
#import "PHAsset+LHPhotos.h"
#import "LHPhotosNavigationController.h"

@interface LHPhotosPageViewController ()<UIScrollViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    UIButton *_selectIamgeButton;
}
@property (nonatomic,assign) CGFloat space;
@property (nonatomic,assign) NSInteger toIndex;//即将移动到
@end

@implementation LHPhotosPageViewController

+(instancetype)initWithSpace:(CGFloat)space{
    LHPhotosPageViewController *page = [[LHPhotosPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@(space),NSBackgroundColorDocumentAttribute:[UIColor blackColor]}];
    page.space = space;

    return page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.dataSource = self;
    self.delegate = self;
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftItem)];

    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    [self.view addSubview:view];

    view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(40)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];


    _selectIamgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectIamgeButton setBackgroundImage:[UIImage imageNamed:[@"LHPhotos.bundle" stringByAppendingPathComponent:@"FriendsSendsPicturesSelectBigYIcon"]] forState:UIControlStateSelected];
    [_selectIamgeButton setBackgroundImage:[UIImage imageNamed:[@"LHPhotos.bundle" stringByAppendingPathComponent:@"FriendsSendsPicturesSelectBigNIcon"]] forState:UIControlStateNormal];
    [_selectIamgeButton addTarget:self action:@selector(selectIamgeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_selectIamgeButton];

    _selectIamgeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_selectIamgeButton]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_selectIamgeButton)]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_selectIamgeButton]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_selectIamgeButton)]];


//    for (UIView *view in self.view.subviews) {
//        if ([view isKindOfClass:[UIScrollView class]]) {
//            NSLog(@"%@",view.subviews);
//        }
//    }
}

#pragma mark - 选中图片按钮
- (void)selectIamgeButtonClick{

    LHPhotosAssetViewController *vc = (LHPhotosAssetViewController *)self.viewControllers[0];

    LHPhotosNavigationController *poto = (LHPhotosNavigationController *)self.navigationController;
    if (vc.asset.assetSelected == NO && self.selectAssets.count >= poto.maxNumber) {
        return;
    }

    vc.asset.assetSelected = !vc.asset.assetSelected;
    _selectIamgeButton.selected = vc.asset.assetSelected;
}

- (void)setSelectImageViewSelected:(BOOL)selected{
    _selectIamgeButton.selected = selected;
}

#pragma mark - 左侧返回按钮响应事件
- (void)leftItem{
//     LHPhotosAssetViewController *vc = (LHPhotosAssetViewController *)self.viewControllers[0];
  //  vc.image = [self getSubImageWithCGRect:CGRectMake(0, 0, vc.image.size.width, vc.image.size.width) image:vc.image centerBool:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setAsset:(PHAsset *)asset image:(UIImage *)image{
   
    LHPhotosAssetViewController *vc = [[LHPhotosAssetViewController alloc] init];
    vc.asset = asset;
    vc.image = image;

    //应为viewdidload执行时间在方法之后，延迟执行选择按钮状态设置
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self setSelectImageViewSelected:asset.assetSelected];
    });
  
    [self setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}


//- (UIImage*)getSubImageWithCGRect:(CGRect)mCGRect image:(UIImage *)image centerBool:(BOOL)centerBool
//{
//
//    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
//    float imgwidth = image.size.width;
//    float imgheight = image.size.height;
//    float viewwidth = mCGRect.size.width;
//    float viewheight = mCGRect.size.height;
//
//    CGRect rect;
//    if(centerBool)
//        rect = CGRectMake((imgwidth-viewwidth)/2, (imgheight-viewheight)/2, viewwidth, viewheight);
//    else{
//        if (viewheight < viewwidth) {
//            if (imgwidth <= imgheight) {
//                rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
//            }else {
//                float width = viewwidth*imgheight/viewheight;
//                float x = (imgwidth - width)/2;
//                if (x > 0) {
//                    rect = CGRectMake(x, 0, width, imgheight);
//                }else {
//                    rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
//                }
//            }
//        }else {
//            if (imgwidth <= imgheight) {
//                float height = viewheight*imgwidth/viewwidth;
//                if (height < imgheight) {
//                    rect = CGRectMake(0, 0, imgwidth, height);
//                }else {
//                    rect = CGRectMake(0, 0, viewwidth*imgheight/viewheight, imgheight);
//                }
//            }else {
//                float width = viewwidth*imgheight/viewheight;
//                if (width < imgwidth) {
//                    float x = (imgwidth - width)/2 ;
//                    rect = CGRectMake(x, 0, width, imgheight);
//                }else {
//                    rect = CGRectMake(0, 0, imgwidth, imgheight);
//                }
//            }
//        }
//    }
//
//    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
//    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
//
//    UIGraphicsBeginImageContext(smallBounds.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextDrawImage(context, smallBounds, subImageRef);
//    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
//    UIGraphicsEndImageContext();
//    CGImageRelease(subImageRef);
//    return smallImage;
//}
//

#pragma mark - UIScrollViewDelegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat width = self.view.frame.size.width;
//    CGFloat contentOffX = scrollView.contentOffset.x;
//    
//    //CGFloat mainProgress = contentOffX
//    if (self.beginScrollProgress) {
//        if (scrollView.contentOffset.x <= width) {
//            
//            if ([self.LHDelegate respondsToSelector:@selector(scrollViewDidScrollLeft:)]) {
//                [self.LHDelegate scrollViewDidScrollLeft:(1-contentOffX/width)];
//            }
//        }else if (scrollView.contentOffset.x >= width+self.space*2){
//            
//            if ([self.LHDelegate respondsToSelector:@selector(scrollViewDidScrollRight:)]) {
//                [self.LHDelegate scrollViewDidScrollRight:(contentOffX-width-self.space*2)/width];
//            }
//        }
//        
//    }
//    
//    if (scrollView.dragging) {
//        
//        if (scrollView.contentOffset.x < 0 ||  scrollView.contentOffset.x > (width+self.space)*2) {
//            if ([self.LHDelegate respondsToSelector:@selector(didFinishAnimatingApper:)]) {
//                [self.LHDelegate didFinishAnimatingApper:self.toIndex];
//            }
//            
//            self.current = self.toIndex;
//        }
//    }
//    
//    if (scrollView.contentOffset.x < 10) {
//        self.toLeftAndRgiht = -1;
//    }else if ( scrollView.contentOffset.x > ((width+self.space)*2-10)){
//        self.toLeftAndRgiht = 1;
//    }else{
//        self.toLeftAndRgiht = 0;
//    }
//    
//}

#pragma mark - UIPageViewControllerDataSource
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    LHPhotosAssetViewController *vc = (LHPhotosAssetViewController *)viewController;
    NSInteger index = [self.assets indexOfObject:vc.asset];
   
    if (index+1 < self.assets.count) {
         LHPhotosAssetViewController *assetVC = [[LHPhotosAssetViewController alloc] init];
        assetVC.asset = self.assets[index+1];
        return assetVC;
    }
  //  self.beginScrollProgress = NO;
    return nil;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    LHPhotosAssetViewController *vc = (LHPhotosAssetViewController *)viewController;
    NSInteger index = [self.assets indexOfObject:vc.asset];
    if (index-1 >= 0) {
        LHPhotosAssetViewController *assetVC = [[LHPhotosAssetViewController alloc] init];
        assetVC.asset = self.assets[index-1];
        return assetVC;
    }

    return nil;
}

#pragma mark - UIPageViewControllerDelegate
// Sent when a gesture-initiated transition begins.
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers NS_AVAILABLE_IOS(6_0){

    LHPhotosAssetViewController *vc = (LHPhotosAssetViewController *)pendingViewControllers[0];
    self.toIndex = [self.assets indexOfObject:vc.asset];
}

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        //改
         self.pageIndex = self.toIndex;
        PHAsset  *asset = self.assets[self.toIndex];
        [self setSelectImageViewSelected:asset.assetSelected];
    }
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
