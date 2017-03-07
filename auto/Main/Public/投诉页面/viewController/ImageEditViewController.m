//
//  ImageEditViewController.m
//  auto
//
//  Created by bangong on 17/2/21.
//  Copyright © 2017年 车质网. All rights reserved.
//

#import "ImageEditViewController.h"
#import "LHPageView.h"

@interface ImageEditViewController ()<LHPageViewDataSource,LHPageViewDelegate>
{
    LHPageView *_pageView;
    NSMutableArray *_imageArray;
    NSInteger _index;
}

@end

@implementation ImageEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createRightItem];

    _pageView = [[LHPageView alloc] initWithFrame:CGRectZero space:10];
    _pageView.dataSource = self;
    _pageView.delegate = self;
    [self.view addSubview:_pageView];
    _pageView.lh_size = self.view.lh_size;

    if (_imageArray.count) {
     [self showImageIndex:_index];
    }
}


-(void)createRightItem{
    UIButton *btn = [LHController createButtnFram:CGRectMake(0, 0, 20, 20) Target:self Action:@selector(rightItemClick) Text:nil];
    [btn setBackgroundImage:[UIImage imageNamed:@"forum_deleteImage"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)rightItemClick{
    if (_imageArray.count == 0) {
        return;
    }

    [_imageArray removeObjectAtIndex:_index];
    if (_imageArray.count == 0) {
        if (self.updateArray) {
            self.updateArray([NSArray array]);
        }
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }


    LHPageViewDirection direction = LHPageViewDirectionReverse;
    if (_imageArray.count > _index) {

    }else{
        direction = LHPageViewDirectionForward;
        _index = _imageArray.count - 1;
    }
    UIImageView *view = [[UIImageView alloc] initWithImage:_imageArray[_index]];
    view.contentMode = UIViewContentModeScaleAspectFit;
    [_pageView setView:view direction:direction anime:YES];

    [self resetTitle];
}


- (void)leftItemBackClick{
    if (self.updateArray) {
        self.updateArray(_imageArray);
    }

    [((BasicNavigationController *)self.navigationController) popViewController];
}

- (void)resetTitle{
    NSInteger count = _imageArray.count > 0?_index+1 : 0;
   self.navigationItem.title = [NSString stringWithFormat:@"%ld/%ld",count,_imageArray.count];
}

- (void)setImageArray:(NSArray *)imageArray showIndex:(NSInteger)index{
    _index = index;
    _imageArray = [imageArray mutableCopy];
    if (_imageArray.count && _pageView) {
        [self showImageIndex:index];
    }
}

- (void)showImageIndex:(NSInteger)index{
    _index = index < _imageArray.count? index : 0;
    UIImageView *view = [[UIImageView alloc] initWithImage:_imageArray[_index]];
    view.contentMode = UIViewContentModeScaleAspectFit;
    [_pageView setView:view direction:LHPageViewDirectionForward anime:NO];

    [self resetTitle];
}

#pragma mark - LHPageViewDataSource
- (UIView *)pageView:(LHPageView *)pageView viewBeforeView:(UIView *)view{

    UIImageView *iamgeView = (UIImageView *)view;
    NSInteger index = [_imageArray indexOfObject:iamgeView.image];
    //关闭ia
    index--;
    if (index >= 0) {
        UIImage *iamge = _imageArray[index];
        UIImageView *iv = [[UIImageView alloc] initWithImage:iamge];
        iv.contentMode = UIViewContentModeScaleAspectFit;

        return iv;
    }
    return nil;
}



- (UIView *)pageView:(LHPageView *)pageViewController viewAfterView:(UIView *)view{
    UIImageView *iamgeView = (UIImageView *)view;
    NSInteger index = [_imageArray indexOfObject:iamgeView.image];
    index++;
 
    if (index < _imageArray.count) {
        UIImage *iamge = _imageArray[index];
        UIImageView *iv = [[UIImageView alloc] initWithImage:iamge];
        iv.contentMode = UIViewContentModeScaleAspectFit;

        return iv;
    }
    return nil;
}

#pragma mark - LHPageViewDelegate
- (void)pageView:(LHPageView *)pageView didFinishAnimating:(BOOL)finished previousView:(UIView *)previousView transitionCompleted:(BOOL)completed{
    if (finished) {
         UIImageView *iamgeView = (UIImageView *)previousView;
        _index = [_imageArray indexOfObject:iamgeView.image];
        [self resetTitle];
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
