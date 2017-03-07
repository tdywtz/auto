//
//  URLFile.h
//  12365auto
//
//  Created by bangong on 16/5/16.
//  Copyright © 2016年 车质网. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface URLFile : NSObject

/**注册协议*/
+ (NSString *)urlStringRegistrationAgreement;
/**登录*/
+ (NSString *)url_login;
/**注册*/
+ (NSString *)url_reg;

/**大品牌*/
+ (NSString *)url_brandlist;
/**车系*/
+ (NSString *)url_seriesWithId:(NSString *)Id;
/**车型*/
+ (NSString *)url_modelListWithSid:(NSString *)sid;

/**省份*/
+ (NSString *)url_pro;
/**市*/
+ (NSString *)url_cityWithPid:(NSString *)pid;
/**县*/
+ (NSString *)url_areaWithCid:(NSString *)cid;


/**
 故障大全页面搜索结果

 @param att 车型[0-11]
 @param place 国别[0-6]
 @param sys 八大系统[0-7]
 @param time 出故障时间[0-5]
 @return <#return value description#>
 */
+ (NSString *)url_searchWithAtt:(NSString *)att
                          place:(NSString *)place
                            sys:(NSString *)sys
                           time:(NSString *)time
                           page:(NSUInteger)page
                            sum:(NSInteger)sum;

#pragma mark - 综述
/**口碑 - 赞*/
+ (NSString *)url_reputationZanWithID:(NSString *)Id;
/**口碑列表*/
+ (NSString *)url_reputationlistWithBid:(NSString *)bid
                                    sid:(NSString *)sid
                                    mid:(NSString *)mid
                                     ID:(NSString *)Id
                                 iOrder:(NSString *)iOrder
                                      p:(NSInteger)p
                                      s:(NSInteger)s;

+ (NSString *)url_reputationlistWithSid:(NSString *)sid
                                 iOrder:(NSString *)iOrder
                                      p:(NSInteger)p
                                      s:(NSInteger)s;
+ (NSString *)url_s_reputationWithSid:(NSString *)sid;
/**口碑 - 评论列表*/
+ (NSString *)url_reputationPLWithID:(NSString *)Id
                                   p:(NSInteger)p
                                   s:(NSInteger)s;
/**口碑 - 评论*/
+ (NSString *)url_reputationReplyWithID:(NSString *)Id;

#pragma mark - 投诉
/**
 投诉列表

 @param title 搜索-关键词
 @param sid 查看车系投诉
 @param p 页码
 @param s 个数
 @return <#return value description#>
 */
+ (NSString *)url_complainlistWithTitle:(NSString *)title
                                    sid:(NSString *)sid
                                      p:(NSInteger)p
                                      s:(NSInteger)s;
/**根据车型获取投诉列表*/
+ (NSString *)url_complainlistWithSid:(NSString *)sid
                                      p:(NSInteger)p
                                      s:(NSInteger)s;
/**投诉搜索*/
+ (NSString *)url_complainListWithTitle:(NSString *)title
                                      p:(NSInteger)p
                                      s:(NSInteger)s;
/**投诉列表->投诉详情*/
+ (NSString *)url_complaininfoWithId:(NSString *)Id;


/**经销商城市*/
+ (NSString *)url_discityWithPid:(NSString *)pid;

/**经销商*/
+ (NSString *)url_disWithPid:(NSString *)pid
                         cid:(NSString *)cid
                         sid:(NSString *)sid;

/**获取用户信息*/
+ (NSString *)url_userWithUid:(NSString *)uid;

/**提交、修改投诉*/
+ (NSString *)url_addcomplain;

#pragma mark - 答疑
/**
 答疑列表
 @param title 搜索时使用
 @param sid 查看车系答疑
 @param t 类别（）
 @param p 页码
 @param s 个数
 @return <#return value description#>
 */
+ (NSString *)url_zjdylistWithTitle:(NSString *)title
                                sid:(NSString *)sid
                                  t:(NSString *)t
                                  p:(NSInteger)p
                                  s:(NSInteger)s;

/**根据车型获取答疑列表*/
+ (NSString *)url_zjdylistWithSid:(NSString *)sid
                                t:(NSString *)t
                             page:(NSInteger)p
                              sum:(NSInteger)s;
/**答疑搜索*/
+ (NSString *)url_zjdylistWithTitle:(NSString *)title
                               page:(NSInteger)page
                                sum:(NSInteger)sum;
/**提问*/
+ (NSString *)url_editZJDY;

/**答疑详情*/
+ (NSString *)url_zjdyinfoWithId:(NSString *)Id;

#pragma mark - 评论列表
/**
 评论列表

 @param Id 文章编号
 @param type 1：新闻，2：投诉，3：答疑  5：新车调查
 @param p <#p description#>
 @param s <#s description#>
 @return <#return value description#>
 */
+ (NSString *)url_plWithId:(NSString *)Id
                      type:(NSString *)type
                      page:(NSInteger)p
                       sum:(NSInteger)s;
/**提交评论*/
+ (NSString *)url_addpl;
///**答疑评论详情*/
//+ (NSString *)urlStringForGetZJDY;




#pragma mark - 个人中心
/**
 根据cpid获取投诉详情
 @param cpid 投诉编号
 */
+ (NSString *)url_tsdetailWithCpid:(NSString *)cpid;

/**根据id获取投诉信息*/
+ (NSString *)url_mytslistWithCpid:(NSString *)cpid;
/**个人中心-我的投诉列表*/
+ (NSString *)url_mytslistWithUid:(NSString *)uid
                             page:(NSInteger)page
                              sum:(NSInteger)sum;
/**个人中心-投诉答疑数量*/
+ (NSString *)url_personalCountWithUid:(NSString *)uid;

/**个人中心-我的提问列表*/
+ (NSString *)url_myzjdyWithUid:(NSString *)uid
                           page:(NSInteger)page
                            sum:(NSInteger)sum;
/**提交评分*/
+ (NSString *)url_complainscoreWithCpid:(NSString *)cpid
                                  score:(NSString *)score;

/**个人中心-修改密码*/
+ (NSString *)url_updatepwdWithUid:(NSString *)uid
                            oldpwd:(NSString *)oldpwd
                            newpwd:(NSString *)newpwd;
/**个人中心-找回密码*/
+ (NSString *)url_sendemailWithUsername:(NSString *)username
                                 origin:(NSString *)origin;


/**申请撤诉*/
+ (NSString *)url_cancelComplain;
/**申请撤诉-原因选择列表*/
+ (NSString *)url_delComTypeList;

/**查看撤诉未成功原因*/
+ (NSString *)url_delComNoReasonWithCpid:(NSString *)cpid;


/**提交用户信息*/
+ (NSString *)url_u_updateinfoWithUid:(NSString *)uid;

/**我的评论*/
+ (NSString *)url_myplWithUid:(NSString *)uid
                         page:(NSUInteger)page
                          sum:(NSInteger)sum;
/**上传头像*/
+ (NSString *)url_uploadAvatarWithUid:(NSString *)uid;


#pragma mark - 综述
/**车系综述 - 车型信息 评分*/
+ (NSString *)urlString_s_indexWithSid:(NSString *)sid;
/**车系综述 - 车型信息 车型故障统计*/
+ (NSString *)urlString_s_index2WithSid:(NSString *)sid;
/**车型综述-投诉头部 满意度&回复率*/
+ (NSString *)url_s_complainWithSid:(NSString *)sid;
/**车系综述-车型参数*/
+ (NSString *)url_mConfig;
+ (NSString *)url_mConfigWithSid:(NSString *)sid
                             mid:(NSString *)mid;
/**车系综述-车型故障信息*/
+ (NSString *)url_dbInfoWithBid:(NSString *)bid
                            sid:(NSString *)sid
                            mid:(NSString *)mid;
@end
