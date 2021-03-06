//
//  MyHeaderView.m
//  chezhiwang
//
//  Created by bangong on 16/9/30.
//  Copyright © 2016年 车质网. All rights reserved.
//

#import "MyHeaderView.h"
#import "LoginViewController.h"
#import "BasicNavigationController.h"
#import "MyCarViewController.h"

@interface MyHeaderView ()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *nameButton;

@end

@implementation MyHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginClick)]];

        self.imageView = [[UIImageView alloc] init];
        self.imageView.layer.cornerRadius = 45;
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.borderWidth = 2;
        self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;

        self.nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.nameButton.layer.borderWidth = 1;
        self.nameButton.layer.cornerRadius = 6;
        [self.nameButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:self.imageView];
        [self addSubview:self.nameButton];

        [self.imageView makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(60);
            make.size.equalTo(CGSizeMake(90, 90));
        }];
        [self.nameButton makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.bottom.equalTo(-18);
            make.height.equalTo(30);
        }];
    }
    return self;
}


- (void)loginClick{

    if (![CZWManager manager].isLogin) {
        UINavigationController *nvc = [LoginViewController instanceSuccess:nil];
        [self.parentVC presentViewController:nvc animated:YES completion:nil];
    }else{
        MyCarViewController *car = [[MyCarViewController alloc] init];
        car.hidesBottomBarWhenPushed = YES;
        [self.parentVC.navigationController pushViewController:car animated:YES];
    }
}

- (void)setTitle:(NSString *)title imageUrl:(NSString *)imageUrl login:(BOOL)login{
    if (login) {
          [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[CZWManager defaultIconImage]];
        [self.nameButton setTitle:title forState:UIControlStateNormal];
        self.nameButton.layer.borderColor = [UIColor clearColor].CGColor;
    }else{
        self.imageView.image = [CZWManager defaultIconImage];
        [self.nameButton setTitle:title forState:UIControlStateNormal];
         self.nameButton.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
