//
//  BreakdownViewController.m
//  auto
//
//  Created by bangong on 15/6/1.
//  Copyright (c) 2015年 车质网. All rights reserved.
//


#import "BreakdownViewController.h"
#import "LHPageViewcontroller.h"
#import "BreakdownChooseViewController.h"
#import "BreakdownBrandViewController.h"
#import "AnswerToolView.h"

@interface BreakdownViewController ()<LHPageViewcontrollerDelegate,AnswerToolViewDelegate>
{
    LHPageViewcontroller *pageViewController;
    AnswerToolView *toolView;
}
@end

@implementation BreakdownViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    BreakdownBrandViewController *brand = [[BreakdownBrandViewController alloc] init];
    brand.contentInsets = UIEdgeInsetsMake(64 + 40, 0, 49, 0);

    BreakdownChooseViewController *choose = [[BreakdownChooseViewController alloc] init];
    choose.contentInsets = UIEdgeInsetsMake(64 + 40, 0, 49, 0);

    pageViewController = [LHPageViewcontroller initWithSpace:0 withParentViewController:self];
    pageViewController.LHDelegate = self;
    pageViewController.controllers = @[brand,choose];
    [pageViewController setViewControllerWithCurrent:0];

    toolView = [[AnswerToolView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 40)];
    toolView.delegate = self;
    toolView.titleArray = @[@"按品牌",@"按条件"];
    toolView.currentIndex = 0;
    toolView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toolView];

    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark -LHPageViewcontrollerDelegate
//变化当前停留在窗口的视图
-(void)didFinishAnimatingApper:(NSInteger)current{
    toolView.currentIndex = current;
}

#pragma mark - AnawerToolViewDelegate
//**点击按钮*/
-(void)selectedButton:(NSInteger)index{
    [pageViewController setViewControllerWithCurrent:index];
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
