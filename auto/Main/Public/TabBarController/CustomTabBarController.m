//
//  CustomTabBarController.m
//  auto
//
//  Created by bangong on 15/6/1.
//  Copyright (c) 2015年 车质网. All rights reserved.
//

#import "CustomTabBarController.h"
#import "BreakdownViewController.h"
#import "ComplainListViewController.h"
#import "AnswerViewController.h"
#import "MyViewController.h"
#import "BasicNavigationController.h"

@interface CustomTabBarController ()<UIAlertViewDelegate>

@end

@implementation CustomTabBarController

-(void)judgement{
//    NSUserDefaults *df =  [NSUserDefaults standardUserDefaults];
//    NSString *dateStr=[df objectForKey:inDate];
//    if (dateStr.length == 0) {
//        return;
//    }
//    //将传入时间转化成需要的格式
//    NSDateFormatter *format=[[NSDateFormatter alloc] init];
//    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *fromdate=[format dateFromString:dateStr];
//   
//    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
//    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
//    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
//   // NSLog(@"fromdate=%@",fromDate);
//
//    //获取当前时间
//    NSDate *date = [NSDate date];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
//    //NSLog(@"enddate=%@",localeDate);
//    
//    
//    double intervalTime = [localeDate timeIntervalSinceReferenceDate] - [fromDate timeIntervalSinceReferenceDate];
//    
//    long lTime = (long)intervalTime;
//
//    NSInteger iDays = lTime/60/60/24;
//    //NSLog(@"%ld",iDays);
//    if (iDays > 15) {
//        [df removeObjectForKey:USER];
//        [df removeObjectForKey:PASSWORD];
//        [df removeObjectForKey:UID];
//    }
}



- (void)viewDidLoad {
    [super viewDidLoad];

    BreakdownViewController   *breakdown = [[BreakdownViewController alloc] init];
    ComplainListViewController  *compain = [[ComplainListViewController alloc] init];
    AnswerViewController         *answer = [[AnswerViewController alloc] init];
    MyViewController                 *my = [[MyViewController alloc] init];

    BasicNavigationController *nvc1 = [[BasicNavigationController alloc] initWithRootViewController:breakdown];
    BasicNavigationController *nvc2 = [[BasicNavigationController alloc] initWithRootViewController:compain];
    BasicNavigationController *nvc3 = [[BasicNavigationController alloc] initWithRootViewController:answer];
    BasicNavigationController *nvc4 = [[BasicNavigationController alloc] initWithRootViewController:my];
    
    breakdown.title = @"故障大全";
    compain.title   = @"最新投诉";
    answer.title    = @"专家答疑";
   // my.title        = @"我";

//    char str[] = "asdgkfjflhkjfglh";
//    char *a = "f";
//     NSLog(@"%p",str);
//     NSLog(@"%p",str + 1);
//     NSLog(@"%p",str + 2);
//     NSLog(@"%p",str + sizeof(char *));
//
//    char *temp = mystrtok(str, a);
//
//    while (temp) {
//
//
//
//    printf("\n======%s\n",temp);
//        temp = mystrtok(NULL, a);
//    }

    self.viewControllers = @[nvc1,nvc2,nvc3,nvc4];
    [self customTabBar];

     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}


char *mystrtok(char *str, const char *delim)
{
    static char *src=NULL;                                         //记下上一次非分隔字符串字符的位置,详见图示
    const char *indelim=delim;                                  //对delim做一个备份
    int flag=1,index=0;
    //每一次调用strtok,flag标记都会使得程序只记录下第一个非分隔符的位置,以后出现非分隔符不再处理
    char *temp=NULL;                                       //程序的返回值

    if(str==NULL)
    {
        str=src;                                               //若str为NULL则表示该程序继续处理上一次余下的字符串
    }
    for(;*str;str++)
    {
        delim=indelim;
        for(;*delim;delim++)
        {
            if(*str==*delim)
            {
                *str=NULL;                    //若找到delim中感兴趣的字符,将该字符置为NULL
                index=1;                         //用来标记已出现感兴趣字符
                break;
            }
        }
        if(*str != NULL && flag ==1)
        {
            temp=str;                              //只记录下当前第一个非感兴趣字符的位置
            flag=0;
        }
        if(*str!=NULL&&flag==0&&index==1)
        {
            src=str;                                   //第二次出现非感兴趣字符的位置(之前一定出现过感兴趣字符)
            return temp;
        }
    }
    src=str;
    //执行该句表明一直未出现过感兴趣字符,或者说在出现了感兴趣的字符后,就没再出现过非感兴趣字符
    return temp;
}


- (void)textFieldTextDidChange:(NSNotification *)noti{
    UITextField *text = noti.object;
    text.text = [text.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(void)customTabBar
{
    NSArray *arrayName = @[@"故障大全",@"最新投诉",@"专家答疑",@"我"];
    NSArray *selectImageNames = @[@"tabbar_故障大全_蓝色",@"tabbar_投诉_蓝色",@"tabbar_答疑_蓝色",@"tabbar_我_蓝色"];
    NSArray *grayImageNames = @[@"tabbar_故障大全_灰色",@"tabbar_投诉_灰色",@"tabbar_答疑_灰色",@"tabbar_我_灰色"];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i  < self.tabBar.items.count; i ++) {

        UITabBarItem *item = self.tabBar.items[i];
        item = [item initWithTitle:arrayName[i] image:[self createImageWithName:grayImageNames[i]] selectedImage:[self createImageWithName:selectImageNames[i]]];

        //设置item字体颜色
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGBValue(0x666666)} forState:UIControlStateNormal];
        //选中颜色
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGBValue(0x009ffb)} forState:UIControlStateSelected];
    }
}

-(UIImage *)createImageWithName:(NSString *)imageName
{
    //UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@",self.imagePath,imageName]];
    UIImage *image = [UIImage imageNamed:imageName];
    //需要对图片进行特殊处理
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - UITabBarControllerDelegate
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    CGRect frame = custommoveView.frame;
//    frame.origin.x = self.tabBar.bounds.size.width/self.viewControllers.count *tabBarController.selectedIndex;
//    [UIView animateWithDuration:0.1 animations:^{
//        custommoveView.frame = frame;
//    }];
//}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.selectedViewController beginAppearanceTransition: YES animated: animated];
    [MobClick beginLogPageView:@"PageOne"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[self.selectedViewController beginAppearanceTransition: NO animated: animated];
    [MobClick endLogPageView:@"PageOne"];
}

//-(void) viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self.selectedViewController endAppearanceTransition];
//}
//
//-(void) viewDidDisappear:(BOOL)animated
//{
//    [self viewDidDisappear:animated];
//    [self.selectedViewController endAppearanceTransition];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
