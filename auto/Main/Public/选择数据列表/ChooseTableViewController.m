//
//  ChooseTableViewController.m
//  chezhiwang
//
//  Created by bangong on 16/12/16.
//  Copyright © 2016年 车质网. All rights reserved.
//

#import "ChooseTableViewController.h"

@interface ChooseTableViewController ()
{
    NSArray *_sectionModels;
    NSArray *_selectIds;
}
@property (nonatomic, strong) ChooseTableView *chooseView;
@property (nonatomic, assign) UITableViewStyle style;

@end

@implementation ChooseTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super init]) {
        _style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createLeftItemBack];

    _chooseView = [[ChooseTableView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.view.frame, _contentInsets) style:_style];
    __weak __typeof(self)weakSelf = self;
    _chooseView.selectBlock = ^(ChooseTableViewModel *model){
        if (weakSelf.selectBlock) {
            weakSelf.selectBlock(model);
        }
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    _chooseView.isIndex = self.isIndex;
    _chooseView.isShowImage = self.isShowImage;
    _chooseView.isShowSection = self.isShowSection;
    _chooseView.sectionModels = _sectionModels;
    _chooseView.selectId = _selectIds;
    
    [self.view addSubview:_chooseView];

    [self setNagitionBar];
}

-(void)setNagitionBar{

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = colorLightBlue;
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)leftItemBackClick{
    if (self.navigationController.viewControllers.count > 1) {
        [((BasicNavigationController *)self.navigationController) popViewController];

    }else{
      [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)reloadData{
    [_chooseView.tableView reloadData];
}


- (void)setSectionModels:(NSArray<__kindof ChooseTableViewSectionModel *> *)sectionModels{
    _sectionModels = sectionModels;
    _chooseView.sectionModels = sectionModels;
}

- (void)setIsIndex:(BOOL)isIndex{
    _isIndex = isIndex;
    _chooseView.isIndex = isIndex;
}

- (void)setIsShowImage:(BOOL)isShowImage{
    _isShowImage = isShowImage;
    _chooseView.isShowImage = isShowImage;
}

- (void)setIsShowSection:(BOOL)isShowSection{
    _isShowSection = isShowSection;
    _chooseView.isShowSection = isShowSection;
}

- (void)setSelectId:(NSArray<NSString *> *)selectId{
    _selectIds = selectId;
    _chooseView.selectId = selectId;
}

- (void)setBlock:(didSelectedRow)boock{
    self.selectBlock = boock;
    if (_chooseView) {
        __weak __typeof(self)weakSelf = self;
        _chooseView.selectBlock = ^(ChooseTableViewModel *model){
            if (weakSelf.selectBlock) {
                weakSelf.selectBlock(model);
            }
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
;
    }
}

- (NSArray <__kindof ChooseTableViewSectionModel *> *)sectionModels{
    return _chooseView.sectionModels;
}

- (NSArray<NSString *> *)selectId{
    return _chooseView.selectId;
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
