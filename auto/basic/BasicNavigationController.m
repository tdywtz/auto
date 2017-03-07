//
//  BasicNavigationController.m
//  12365auto
//
//  Created by bangong on 16/3/21.
//  Copyright © 2016年 车质网. All rights reserved.
//

#import "BasicNavigationController.h"

#define mainScreenWidth [UIScreen mainScreen].bounds.size.width

@interface BasicNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
{
    CGPoint startTouch;
    UIImageView *lastScreenShotView;
    UIView *blackMask;
}

@property(nonatomic, strong) UIView *backgroundView;
@property(nonatomic, strong) NSMutableArray *screenShotsList;

@end

@implementation BasicNavigationController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        CGRect frame = self.navigationBar.frame;
        self.alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height+20)];
        self.alphaView.backgroundColor = colorLightBlue;
        [self.view insertSubview:self.alphaView belowSubview:self.navigationBar];
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
        self.navigationBar.layer.masksToBounds = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   //UIScreenEdgePanGestureRecognizer
   // self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
    [self setNagitionBar];

    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.edges = UIRectEdgeLeft;
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSInteger idsx = [self.viewControllers indexOfObject:viewController];
    while (self.screenShotsList.count > idsx + 1) {
        [self.screenShotsList removeLastObject];
    }
    return [super popToViewController:viewController animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.screenShotsList.count) {
        UIImage *image = nil;
        if (self.viewControllers.count == 1) {
            image = [self captureWithView:[UIApplication sharedApplication].keyWindow.rootViewController.view];

        }else{
            image = [self captureWithView:self.view];
        }
        [self BeganWithImage:image];
        [self addCapture];
        [self moveViewWithX:WIDTH view:self.view];
        [super pushViewController:viewController animated:NO];
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0 view:self.view];
        }];
    }else{
        [self addCapture];
        [super pushViewController:viewController animated:animated];
    }
}

- (void)popViewController{
    [self BeganWithImage:[self.screenShotsList lastObject]];
    [self moveViewWithX:0 view:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        [self moveViewWithX:mainScreenWidth view:self.view];
    } completion:^(BOOL finished) {
        if (self.screenShotsList.count) {
            [self.screenShotsList removeLastObject];
        }
        [self popViewControllerAnimated:NO];
        CGRect frame = self.view.frame;
        frame.origin.x = 0;
        self.view.frame = frame;
    }];
}

- (void)pan:(UIPanGestureRecognizer *)recoginzer{
     //If the viewControllers has only one vc or disable the interaction, then return.
        if (self.viewControllers.count <= 1) return;
    
        // we get the touch position by the window's coordinate
        CGPoint touchPoint = [recoginzer locationInView:[UIApplication sharedApplication].keyWindow];
        // begin paning, show the backgroundView(last screenshot),if not exist, create it.
        if (recoginzer.state == UIGestureRecognizerStateBegan) {

            startTouch = touchPoint;
            [self BeganWithImage:[self.screenShotsList lastObject]];

        }else if (recoginzer.state == UIGestureRecognizerStateEnded){
    
            if (touchPoint.x - startTouch.x > 50)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    [self moveViewWithX:mainScreenWidth view:self.view];
                } completion:^(BOOL finished) {
                    if (self.screenShotsList.count) {
                         [self.screenShotsList removeLastObject];
                    }
                    [self popViewControllerAnimated:NO];
                    CGRect frame = self.view.frame;
                    frame.origin.x = 0;
                    self.view.frame = frame;
                }];
            }
            else
            {
                [UIView animateWithDuration:0.3 animations:^{
                    [self moveViewWithX:0 view:self.view];
                } completion:^(BOOL finished) {
    
                    self.backgroundView.hidden = YES;
                }];
            }
            return;
    
            // cancal panning, alway move to left side automatically
        }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
    
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0 view:self.view];
            } completion:^(BOOL finished) {
              
                self.backgroundView.hidden = YES;
            }];
    
            return;
        }
    
            [self moveViewWithX:touchPoint.x - startTouch.x view:self.view];

}

- (void)BeganWithImage:(UIImage *)image{
    self.backgroundView.hidden = NO;

    if (lastScreenShotView) [lastScreenShotView removeFromSuperview];

    lastScreenShotView = [[UIImageView alloc]initWithImage:image];
    [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];

}

- (void)moveViewWithX:(float)x view:(UIView *)view
{

  //  NSLog(@"Move to:%f",x);
    x = x>WIDTH?WIDTH:x;
    x = x<0?0:x;

    CGRect frame = view.frame;
    frame.origin.x = x;
    view.frame = frame;

    float scale = (1-WIDTH/7000) + x/7000;
    float alpha = 0.4 - (x/800);

    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    blackMask.alpha = alpha;
}



-(void)setNagitionBar{
    if (SYSTEM_VERSION_GREATER_THAN(8.0)) {
        self.navigationController.hidesBarsOnTap = NO;
    }
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barStyle = UIBarStyleBlack;
    //self.navigationBar.barTintColor = colorDeepBlue;
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}


- (void)addCapture{
    if (self.viewControllers.count == 1) {
        UIImage *image = [self captureWithView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        if (image) {
            [self.screenShotsList addObject:image];
        }
    }else{
        UIImage *image = [self captureWithView:self.view];
        if (image) {
            [self.screenShotsList addObject:image];
        }
    }
}

- (UIImage *)captureWithView:(UIView *)view
{

    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return img;
}


#pragma mark - 
- (NSMutableArray *)screenShotsList{
    if (_screenShotsList == nil) {
        _screenShotsList = [NSMutableArray array];
    }
    return _screenShotsList;
}

- (UIView *)backgroundView{
    if (!_backgroundView)
    {
        CGRect frame = [UIScreen mainScreen].bounds;
        _backgroundView = [[UIView alloc]initWithFrame:frame];
        _backgroundView.backgroundColor = [UIColor blackColor];


        blackMask = [[UIView alloc]initWithFrame:frame];
        blackMask.backgroundColor = [UIColor blackColor];
        [_backgroundView addSubview:blackMask];
    }

    [self.view.superview insertSubview:_backgroundView belowSubview:self.view];

    return _backgroundView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{

    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
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
