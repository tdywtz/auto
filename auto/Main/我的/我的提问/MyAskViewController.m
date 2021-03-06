//
//  MyAskViewController.m
//  auto
//
//  Created by bangong on 15/6/10.
//  Copyright (c) 2015年 车质网. All rights reserved.
//

#import "MyAskViewController.h"
#import "AskViewController.h"
#import "MyAskCell.h"
#import "MyAskModel.h"
#import "MyAskShowCell.h"

@interface MyAskViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    MyAskModel *openModel;
    NSInteger _count;
}
@property (nonatomic,strong) MyAskModel *model;
@end

@implementation MyAskViewController

-(void)loadData{
    NSString *url = [URLFile url_myzjdyWithUid:CZWManagerInstance.userID page:_count sum:10];
    
    [HttpRequest GET:url success:^(id responseObject) {
        if (_count == 1) {

            [_dataArray removeAllObjects];

        }
        [_tableView.mj_header endRefreshing];
        if ([responseObject[@"rel"] count] == 0){
            [_tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [_tableView.mj_footer endRefreshing];
        }

        for (NSDictionary *dict in responseObject[@"rel"]) {
            MyAskModel *model = [MyAskModel mj_objectWithKeyValues:dict];
            [_dataArray addObject:model];
        }

        [_tableView reloadData];
        if (_dataArray.count == 0) {
            self.backgroundView.contentLabel.text = @"暂无提问";
            self.backgroundView.hidden = NO;
        }else{
            self.backgroundView.hidden = YES;
        }
    } failure:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的提问";
    self.view.backgroundColor = [UIColor whiteColor];
    self.model = [[MyAskModel alloc] init];

    [self createRightItem];
    [self createTabelView];

}


-(void)createTabelView{
    _dataArray = [[NSMutableArray alloc] init];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
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


#pragma mark - 跳转我要提问页面
-(void)createRightItem{
    UIButton *askButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [askButton setImage:[UIImage imageNamed:@"answer_question_right"] forState:UIControlStateNormal];
    askButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    askButton.frame = CGRectMake(0, 0, 30, 20);
    [askButton addTarget:self action:@selector(askButtonClick) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:askButton];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)askButtonClick{
    AskViewController *ask = [[AskViewController alloc] init];
    [self.navigationController pushViewController:ask animated:YES];
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
    MyAskModel *model = _dataArray[indexPath.row];
    if ([model isEqual:self.model]) {
        MyAskShowCell *showCell = [_tableView dequeueReusableCellWithIdentifier:@"showCell"];
        if (!showCell) {
            showCell = [[MyAskShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"showCell"];
            showCell.selectionStyle = UITableViewCellSelectionStyleNone;
            showCell.contentView.backgroundColor = RGB_color(240, 240, 240, 1);
        }
        [showCell setModel:model];
        return showCell;
    }
    
    MyAskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[MyAskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    model.isOpen = NO;
    cell.contentView.backgroundColor = [UIColor clearColor];
    if ([model isEqual:openModel]) {
        model.isOpen = YES;
        cell.contentView.backgroundColor = RGB_color(240, 240, 240, 1);
    }
    cell.model = model;
    
    return cell;
}

//-(void)btnClick{
//    
//}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if ([self.model isEqual:_dataArray[indexPath.row]]) {
        return 150;
    }
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    MyAskModel *model = _dataArray[indexPath.row];
   
   openModel = nil;
   
    self.model.answer = model.answer;
    self.model.answerdate = model.answerdate;
    self.model.question = model.question;
    NSInteger index = [_dataArray indexOfObject:self.model];
    
    if (index == NSNotFound) {
        openModel = model;
        
        [_dataArray insertObject:self.model atIndex:indexPath.row+1];
    }else{
        if (index == indexPath.row) {
            [_dataArray removeObject:self.model];
        }else if (index == indexPath.row+1){
            [_dataArray removeObject:self.model];
        }else{
            
            openModel = model;
            
            MyAskModel *obj = [[MyAskModel alloc] init];
            obj.answer = model.answer;
            obj.answerdate = model.answerdate;
            obj.question = model.question;
            [_dataArray insertObject:obj atIndex:indexPath.row+1];
            [_dataArray removeObject:self.model];
            self.model = obj;
            
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
