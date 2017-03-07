//
//  BasicViewController.m
//  12365auto
//
//  Created by bangong on 16/3/21.
//  Copyright © 2016年 车质网. All rights reserved.
//

#import "BasicViewController.h"

@implementation BasicBackgroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"auto_backgruondView_暂无"];

        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = colorBlack;

        [self addSubview:_imageView];
        [self addSubview:_contentLabel];

        [_imageView makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.centerY.equalTo(-20);
        }];

        [_contentLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.width.lessThanOrEqualTo(WIDTH - 30);
            make.top.equalTo(_imageView.bottom).offset(20);
        }];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return  nil;
}

@end



#pragma mark - BasicViewController
@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    self.view.backgroundColor = [UIColor whiteColor];
    if (self.navigationController.viewControllers.count > 1) {
        [self createLeftItemBack];
    }

   // [self setNagitionBar];

}

#pragma mark - 注册通知
-(void)keyboardNotificaion{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardShow:(NSNotification *)notification
{

}

-(void)keyboardHide:(NSNotification *)notification
{
    
}


-(void)setNagitionBar{
    //    if (SYSTEM_VERSION_GREATER_THAN(8.0)) {
    //        self.navigationController.hidesBarsOnTap = NO;
    //    }
    //
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = colorDeepBlue;
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [MobClick endLogPageView:@"PageOne"];
}

-(void)createLeftItemBack{
    

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 40);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-5, 10, 10.5, 20)];
    UIImage*leftImage=[UIImage imageNamed:@"bar_btn_icon_returntext"];

    imageView.image = leftImage;
    [button addSubview:imageView];

    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];


    [button addTarget:self action:@selector(leftItemBackClick) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)leftItemBackClick{

    if ([self.navigationController isKindOfClass:[BasicNavigationController class]]) {
        [((BasicNavigationController *)self.navigationController) popViewController];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _scrollView.alwaysBounceVertical = YES;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (BasicBackgroundView *)backgroundView{
    if (_backgroundView == nil) {
        _backgroundView = [[BasicBackgroundView alloc] initWithFrame:self.view.frame];
        _backgroundView.hidden = YES;
        [self.view addSubview:_backgroundView];
    }
    return _backgroundView;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
