//
//  CZWSearchVC.m
//  auto
//
//  Created by bangong on 17/2/27.
//  Copyright © 2017年 车质网. All rights reserved.
//

#import "CZWSearchVC.h"

@interface CZWSearchVC ()
{
    UISearchController *_searchController;
}
@end

@implementation CZWSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];

    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.navigationItem.titleView = _searchController.searchBar;
  //  self.definesPresentationContext = YES;
    _searchController.hidesNavigationBarDuringPresentation = NO;
   //searchController.dimsBackgroundDuringPresentation =
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
