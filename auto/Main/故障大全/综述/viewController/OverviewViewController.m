//
//  OverviewViewController.m
//  chezhiwang
//
//  Created by bangong on 16/12/29.
//  Copyright © 2016年 车质网. All rights reserved.
//

#import "OverviewViewController.h"
#import "ComplainDetailsViewController.h"
#import "ComplainListViewController.h"

#import "HomepageSectionModel.h"
#import "HomepageNewsModel.h"
#import "HomepageComplainModel.h"

#import "OverviewView.h"
#import "HomepageNewsImageCell.h"
#import "HomepageNewsTextCell.h"
#import "HomepageComplainCell.h"
#import "HomepageSectionHeaderView.h"
#import "HomepageSectionFooterView.h"
#import "LCReputationDetailsViewController.h"

#import "ReputationCell.h"


@interface OverviewViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_dataArray;
    OverviewView *headerView;
}
@end

@implementation OverviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.contentInset = self.contentInsets;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 200;

    [self.view addSubview:_tableView];


    headerView = [[OverviewView alloc] initWithFrame:CGRectMake(0, self.contentInsets.top, WIDTH, 100)];
    headerView.parentVC = self;
     _tableView.tableHeaderView = headerView;

    __weak __typeof(headerView)weakHeaderView = headerView;
    __weak __typeof(_tableView)weakTableView = _tableView;
    [headerView setUpdateBlock:^(CGRect frame) {
        weakTableView.tableHeaderView = weakHeaderView;
    }];



    HomepageSectionModel *complainSectionModel = [[HomepageSectionModel alloc] init];
    complainSectionModel.headTitle = @"投诉";
    complainSectionModel.headImageName = @"auto_综述_投诉";
    complainSectionModel.footTitle = @"更多投诉";
    complainSectionModel.headLineColor = colorYellow;
   // complainSectionModel.pushClass = [ComplainListViewController class];

    HomepageSectionModel *three = [[HomepageSectionModel alloc] init];
    three.headTitle = @"口碑";
    three.headImageName = @"auto_综述_口碑";
    three.footTitle = @"更多口碑";
    three.headLineColor = colorGreen;
   
    _dataArray = @[complainSectionModel,three];

    [self loadDataScore];//评分
    [self loadDataStatistics];//故障统计
    [self loadComplainData];
    [self loadReputationData];
}



- (void)loadDataScore{
    __weak __typeof(self)_self = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [URLFile urlString_s_indexWithSid:_seriesID];
    [HttpRequest GET:url success:^(id responseObject) {
        
        [MBProgressHUD hideHUDForView:_self.view animated:YES];
        [headerView setDataScore:responseObject];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:_self.view animated:YES];
    }];
}

//故障统计
- (void)loadDataStatistics{
    NSString *url = [URLFile urlString_s_index2WithSid:_seriesID];
    [HttpRequest GET:url success:^(id responseObject) {
        [headerView setDataStatistics:responseObject];
        _tableView.tableHeaderView = headerView;
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadComplainData{
    NSString *url = [URLFile url_complainlistWithSid:_seriesID p:1 s:5];
    [HttpRequest GET:url success:^(id responseObject) {
        HomepageSectionModel *sectionModel = _dataArray[0];
        sectionModel.rowModels = [HomepageComplainModel mj_objectArrayWithKeyValuesArray:responseObject[@"rel"]];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadReputationData{
    [HttpRequest GET:[URLFile url_reputationlistWithSid:_seriesID iOrder:nil p:1 s:1] success:^(id responseObject) {
        HomepageSectionModel *sectionModel = _dataArray[1];
        sectionModel.rowModels = [ReputationModel mj_objectArrayWithKeyValuesArray:responseObject[@"rel"]];
        [_tableView reloadData];
    } failure:^(NSError *error) {

    }];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    HomepageSectionModel *sectionModel = _dataArray[section];
    return sectionModel.rowModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HomepageSectionModel *sectionModel = _dataArray[indexPath.section];
        HomepageComplainModel *model = sectionModel.rowModels[indexPath.row];
        HomepageComplainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"complainCell"];
        if (!cell) {
            cell = [[HomepageComplainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"complainCell"];
        }
        cell.complainModel = model;
        return cell;

    }else{
        HomepageSectionModel *sectionModel = _dataArray[indexPath.section];
        ReputationModel *model = sectionModel.rowModels[indexPath.row];
        ReputationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reputationCell"];
        if (!cell) {
            cell  = [[ReputationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reputationCell"];
        }
        cell.model = model;
        return cell;

    }
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomepageSectionModel *sectionModel = _dataArray[indexPath.section];
        NSObject *obj = sectionModel.rowModels[indexPath.row];
    if ([obj isKindOfClass:[HomepageComplainModel class]]) {
        HomepageComplainModel *model = (HomepageComplainModel*)obj;
        ComplainDetailsViewController *detail = [[ComplainDetailsViewController alloc] init];
        detail.cid = model.cpid;
        [self.navigationController pushViewController:detail animated:YES];
    }else if ([obj isKindOfClass:[ReputationModel class]]){
        ReputationModel *model = (ReputationModel*)obj;
        LCReputationDetailsViewController *details = [[LCReputationDetailsViewController alloc] init];
        details.ID = model.ID;
        [self.navigationController pushViewController:details animated:YES];
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomepageSectionModel *sectionModel = _dataArray[section];
    HomepageSectionHeaderView *header = [[HomepageSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    header.sectionModel = sectionModel;
    return header;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    HomepageSectionModel *sectionModel = _dataArray[section];
    HomepageSectionFooterView *footer = [[HomepageSectionFooterView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    [footer noSpace];
    footer.sectionModel = sectionModel;
    __weak __typeof(self)_self = self;
   [footer setClick:^{
       if (_self.moreClick) {
           _self.moreClick(section);
       }
   }];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

-(void)viewApper{
    _tableView.scrollsToTop = YES;
}

-(void)viewDisappear{
    _tableView.scrollsToTop = NO;
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
