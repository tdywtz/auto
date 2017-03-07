//
//  ResultViewController.m
//  auto
//
//  Created by bangong on 15/6/9.
//  Copyright (c) 2015年 车质网. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultCell.h"
#import "ResultModel.h"
#import "LCSeriesViewController.h"

@interface ResultViewController ()<UITableViewDataSource,UITableViewDelegate>
{
   NSMutableArray *_dataArray;
   UITableView *_tableView;
   NSInteger _count;
}
@end

@implementation ResultViewController

-(void)loadData{

    NSString *url = [URLFile url_searchWithAtt:_att place:_place sys:_sys time:_time page:_count sum:10];

    [HttpRequest GET:url success:^(id responseObject) {
        if (_count == 1) {

            [_dataArray removeAllObjects];
        }
        [_tableView.mj_header endRefreshing];

        if ([responseObject[@"rel"] count] == 0) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [_tableView.mj_footer endRefreshing];
        }

        for (NSDictionary *dict in responseObject[@"rel"]) {
            ResultModel *model = [ResultModel mj_objectWithKeyValues:dict];
            int count = 0;
            for (NSDictionary *subDict in dict[@"gz"][@"rel"]) {
                count ++;
                if (count > 2) {
                    break;
                }
                NSString *text = [NSString stringWithFormat:@"%@:%@:%@个",subDict[@"system"],subDict[@"issue"],subDict[@"count"]];
                NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:text];
                [att yy_setColor:colorOrangeRed range:[text rangeOfString:subDict[@"count"]]];
                if (count == 1) {
                    model.attribut1 = att;
                }else if (count == 2){
                    model.attribut2 = att;
                }

            }
            [_dataArray addObject:model];
        }
        if (_dataArray.count) {
            self.backgroundView.hidden = YES;
        }else{
            self.backgroundView.contentLabel.text = @"未搜索到数据";
            self.backgroundView.hidden = NO;
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"搜索结果";
    _count = 1;
    _dataArray = [NSMutableArray array];

    [self createTableView];
}



-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

    __weak __typeof(self)weakSelf = self;
    _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        _count = 1;
        [weakSelf loadData];
    }];
    _count = 1;
    [_tableView.mj_header beginRefreshing];

    _tableView.mj_footer = [MJDIYAutoFooter footerWithRefreshingBlock:^{
        _count ++;
        [weakSelf loadData];
    }];
    _tableView.mj_footer.automaticallyHidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource/UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[ResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    //设置右侧的提示样式
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    ResultModel *model = _dataArray[indexPath.row];
    cell.model = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ResultModel *model = _dataArray[indexPath.row];
    LCSeriesViewController *series = [[LCSeriesViewController alloc] init];
    series.seriesID = model.seriesid;
    series.title = model.name;
    [self.navigationController pushViewController:series animated:YES];
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
