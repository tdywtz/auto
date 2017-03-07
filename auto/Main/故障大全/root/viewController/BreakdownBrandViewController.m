//
//  BreakdownBrandViewController.m
//  auto
//
//  Created by bangong on 17/2/14.
//  Copyright © 2017年 车质网. All rights reserved.
//

#import "BreakdownBrandViewController.h"
#import "ChooseTableView.h"
#import "LCSeriesViewController.h"

@interface BreakdownBrandViewController ()
{
    ChooseTableView *chooseTable;
}
@end

@implementation BreakdownBrandViewController

- (void)viewDidLoad {
    self.isShowImage = YES;
    self.isIndex = YES;
    self.isShowSection = YES;

    [super viewDidLoad];

    chooseTable = [[ChooseTableView alloc] initWithFrame:CGRectMake(WIDTH + 10, self.contentInsets.top,WIDTH - WIDTH/3, HEIGHT - self.contentInsets.bottom - self.contentInsets.top) style:UITableViewStylePlain];
    chooseTable.backgroundColor = [UIColor whiteColor];
    chooseTable.layer.shadowColor = [UIColor blackColor].CGColor;
    chooseTable.layer.shadowOffset = CGSizeMake(-5, 3);
    chooseTable.layer.shadowOpacity = 0.5;
    chooseTable.isShowImage = YES;
    chooseTable.isShowSection = YES;
    __weak __typeof(self)_self = self;

    chooseTable.selectBlock = ^(ChooseTableViewModel *model){
        LCSeriesViewController *series = [[LCSeriesViewController alloc] init];
        series.seriesID = model.ID;
        series.title = model.title;
        series.hidesBottomBarWhenPushed = YES;
         [_self showChooseTable:NO];
        [_self.navigationController pushViewController:series animated:YES];
    };
    [chooseTable addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]];
    [self.view addSubview:chooseTable];

    [self setBlock:^(ChooseTableViewModel *model) {
        [_self loadModelData:model.ID];
        [_self showChooseTable:YES];
    }];


    [self loadData];
}

- (void)loadData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof(self)weakSelf = self;
    [ChooseTableViewSectionModel brand:^(NSArray<ChooseTableViewSectionModel *> *sectionModels) {
        weakSelf.sectionModels = sectionModels;
        [weakSelf reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark - 滑动
-(void)pan:(UIPanGestureRecognizer *)pan{

    CGPoint point = [pan translationInView:self.view];

    if (point.x+pan.view.frame.origin.x > WIDTH/3) {
        pan.view.center = CGPointMake(point.x+pan.view.center.x, pan.view.center.y);
        [pan setTranslation:CGPointZero inView:self.view];
    }

    if (pan.state == UIGestureRecognizerStateEnded) {
        if (pan.view.frame.origin.x< WIDTH/3+30) {
            [self showChooseTable:YES];
        }else{
            [self showChooseTable:NO];
        }
    }
}

- (void)showChooseTable:(BOOL)show{
    if (show) {
        chooseTable.lh_left = WIDTH + 10;
        [UIView animateWithDuration:0.3 animations:^{
            chooseTable.lh_left = WIDTH/3;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            chooseTable.lh_left = WIDTH + 10;
        }];
    }
}


- (void)loadModelData:(NSString *)bid{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [URLFile url_seriesWithId:bid];
    [HttpRequest GET:url success:^(id responseObject) {

        NSMutableArray *mArray = [[NSMutableArray alloc] init];

        for (NSDictionary *dict in responseObject[@"rel"]) {
            ChooseTableViewSectionModel *sectionModel = [[ChooseTableViewSectionModel alloc] init];
            sectionModel.title = dict[@"brands"];

            NSMutableArray *rowModels = [[NSMutableArray alloc] init];
            for (NSDictionary *subDic in dict[@"series"]) {
                ChooseTableViewModel *model = [[ChooseTableViewModel alloc] init];
                model.ID = subDic[@"seriesid"];
                model.title = subDic[@"seriesname"];
                model.imageUrl = subDic[@"logo"];
                [rowModels addObject:model];
            }
            sectionModel.rowModels = rowModels;
            [mArray addObject:sectionModel];
        }
        chooseTable.sectionModels = mArray;
        [chooseTable.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
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
