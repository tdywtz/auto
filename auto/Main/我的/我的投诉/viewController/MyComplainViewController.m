//
//  MyComplainViewController.m
//  auto
//
//  Created by bangong on 15/6/10.
//  Copyright (c) 2015年 车质网. All rights reserved.
//

#import "MyComplainViewController.h"
#import "MyComplainCell.h"
#import "MyComplainModel.h"
#import "MyComplainShowCell.h"
#import "ComplainViewController.h"


@interface MyComplainViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    UITableView *_tableView;

    MyComplainModel *myModel;
    MyComplainModel *openModel;

    NSArray *showCells;

    NSInteger _count;
}

@end

@implementation MyComplainViewController

-(void)loadData{

    NSString *url  = [URLFile url_mytslistWithUid:CZWManagerInstance.userID page:_count sum:10];
  __weak __typeof(self)weakSelf = self;
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
          MyComplainModel *model = [MyComplainModel mj_objectWithKeyValues:dict];
     
          [_dataArray addObject:model];
      }
      if (_dataArray.count == 0) {
          [weakSelf createSpace];
      }else{
          weakSelf.backgroundView.hidden = YES;
      }

      [_tableView reloadData];

  } failure:^(NSError *error) {
      [_tableView.mj_header endRefreshing];
      [_tableView.mj_footer endRefreshing];

  }];
}

- (void)viewDidLoad {
    [super viewDidLoad];


    _count = 1;
    self.navigationItem.title = @"我的投诉";
    self.view.backgroundColor = [UIColor whiteColor];
   _dataArray = [[NSMutableArray alloc] init];

    [self creaRightItem];
    [self createTableView];

}

-(void)createTableView{

    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    [self loadData];
    __weak __typeof(self)weakSelf = self;
    _tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        _count = 1;
        [weakSelf loadData];
    }];

    [_tableView.mj_header beginRefreshing];

    _tableView.mj_footer = [MJDIYAutoFooter footerWithRefreshingBlock:^{
        _count ++;
        [weakSelf loadData];
    }];
    _tableView.mj_footer.automaticallyHidden = YES;
}

-(void)createSpace{
    self.backgroundView.contentLabel.text = @"暂无投诉";
    self.backgroundView.hidden = NO;
}

#pragma mark - 我要投诉
-(void)creaRightItem{

    UIButton *complainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [complainButton setImage:[UIImage imageNamed:@"auto_投诉列表_投诉"] forState:UIControlStateNormal];
    complainButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    complainButton.frame = CGRectMake(0, 0, 30, 20);
    [complainButton addTarget:self action:@selector(complainButtonClick) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:complainButton];
}
//投诉
-(void)complainButtonClick{
    ComplainViewController *complain =[[ComplainViewController alloc] init];
    [self.navigationController pushViewController:complain animated:YES];
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
    MyComplainModel *model = [_dataArray objectAtIndex:indexPath.row];
    
    if ([model isEqual:myModel]) {

        MyComplainShowCell *showcell = [tableView dequeueReusableCellWithIdentifier:@"showcell"];
        if (!showcell) {
            showcell = [[MyComplainShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"showcelle"];
        }
        showcell.selectionStyle = UITableViewCellSelectionStyleNone;
        showcell.parentController = self;
        [showcell setModel:model];
        return showcell;
    }
    
    
    MyComplainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[MyComplainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    model.isOpen = NO;
    cell.contentView.backgroundColor = [UIColor clearColor];
    if ([model isEqual:openModel]) {
        model.isOpen = YES;
    }
    
    cell.model = model;
    return cell;

}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    MyComplainModel *model = _dataArray[indexPath.row];

    openModel = nil;
    
    NSInteger index = [_dataArray indexOfObject:myModel];
    
    if (index == NSNotFound) {
        openModel = model;
        myModel = [MyComplainModel mj_objectWithKeyValues:model.mj_keyValues];
        [_dataArray insertObject:myModel atIndex:indexPath.row+1];
    }else{

        if (index == indexPath.row) {

           [_dataArray removeObject:myModel];
        }else if (index-1 == indexPath.row){
            [_dataArray removeObject:myModel];
        }else{
            
            openModel = model;
            
            MyComplainModel *obj = [MyComplainModel mj_objectWithKeyValues:model.mj_keyValues];
            [_dataArray insertObject:obj atIndex:indexPath.row+1];
            [_dataArray removeObject:myModel];
            
            myModel = obj;
            
        }
    } 
       [_tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
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
