//
//  URLFile.m
//  12365auto
//
//  Created by bangong on 16/5/16.
//  Copyright © 2016年 车质网. All rights reserved.
//

#import "URLFile.h"

@interface NSString (URLFile)

@end

@implementation NSString (URLFile)

- (NSString *)appendingWithValue:(NSString *)value key:(NSString *)key{

    if (value && key) {
        return  [NSString stringWithFormat:@"%@&%@=%@",self,key,value];
    }
    return self;
}

- (NSString *)appendingWithPage:(NSInteger)page sum:(NSInteger)sum{
    if (page > 0 && sum > 0) {
        return  [NSString stringWithFormat:@"%@&p=%ld&s=%ld",self,page,sum];
    }
    return self;
}

@end

#pragma mark - urlfile
@implementation URLFile

/**车质网专用*/
+ (NSString *)stringForCZWServiceWithAct:(NSString *)act{
    return [NSString stringWithFormat:@"%@%@%@",[self prefixString],@"/forCZWService.ashx?",act];
}
/**公用*/
+ (NSString *)stringForCommonServiceWithAct:(NSString *)act{
    return [NSString stringWithFormat:@"%@%@%@",[self prefixString],@"/forCommonService.ashx?",act];
}

/**前缀*/
+ (NSString *)prefixString{

#if DEBUG
    NSString *base = [[NSUserDefaults standardUserDefaults] objectForKey:URL_PrefirString_debug];
    if (base) {
        return base;
    }
    return  @"http://192.168.1.114:8888/AppServer";
#else
    NSString *base = [[NSUserDefaults standardUserDefaults] objectForKey:URL_PrefirString_release];
    if (base) {
        return base;
    }
    return  @"http://m.12365auto.com/AppServer";
#endif
}

/**注册协议*/
+ (NSString *)urlStringRegistrationAgreement{
    return @"http://m.12365auto.com/user/agreeForIOS.shtml";
}

/**登录*/
+ (NSString *)url_login{
    return [self stringForCommonServiceWithAct:@"act=login"];
}

/**注册*/
+ (NSString *)url_reg{
    return [self stringForCommonServiceWithAct:@"act=reg"];
}


/**大品牌*/
+ (NSString *)url_brandlist{
    return [self stringForCommonServiceWithAct:@"act=brandlist"];
}

/**车系*/
+ (NSString *)url_seriesWithId:(NSString *)Id{
    NSString *parameter = @"act=serieslist";
    parameter = [parameter appendingWithValue:Id key:@"id"];
    return [self stringForCommonServiceWithAct:parameter];
}

/**车型*/
+ (NSString *)url_modelListWithSid:(NSString *)sid{
    NSString *parameter = @"act=modellist";
    parameter = [parameter appendingWithValue:sid key:@"sid"];
    return [self stringForCommonServiceWithAct:parameter];
}

/**省份*/
+ (NSString *)url_pro{
    return [self stringForCommonServiceWithAct:@"act=pro"];
}

/**市*/
+ (NSString *)url_cityWithPid:(NSString *)pid{
    NSString *parameter = @"act=city";
    parameter = [parameter appendingWithValue:pid key:@"pid"];
    return [self stringForCommonServiceWithAct:parameter];
}

/**县*/
+ (NSString *)url_areaWithCid:(NSString *)cid{
    NSString *parameter = @"act=area";
    parameter = [parameter appendingWithValue:cid key:@"cid"];
    return [self stringForCommonServiceWithAct:parameter];
}


/**故障大全页面搜索结果*/
+ (NSString *)url_searchWithAtt:(NSString *)att
                          place:(NSString *)place
                            sys:(NSString *)sys
                           time:(NSString *)time
                           page:(NSUInteger)page
                            sum:(NSInteger)sum{
    NSString *parameter = @"act=search";
    parameter = [parameter appendingWithValue:att key:@"att"];
    parameter = [parameter appendingWithValue:place key:@"place"];
    parameter = [parameter appendingWithValue:sys key:@"sys"];
    parameter = [parameter appendingWithValue:time key:@"time"];
    parameter = [parameter appendingWithPage:page sum:sum];
    return [self stringForCommonServiceWithAct:parameter];
}

#pragma mark - 综述
/**发现-口碑 - 赞*/
+ (NSString *)url_reputationZanWithID:(NSString *)Id{
    NSString *parameter = @"act=reputationZan";
    parameter = [parameter appendingWithValue:Id key:@"id"];
    return [self stringForCommonServiceWithAct:parameter];
}

/**发现-口碑列表*/
+ (NSString *)url_reputationlistWithBid:(NSString *)bid
                                    sid:(NSString *)sid
                                    mid:(NSString *)mid
                                     ID:(NSString *)Id
                                 iOrder:(NSString *)iOrder
                                      p:(NSInteger)p
                                      s:(NSInteger)s{
    NSString *parameter = @"act=reputationlist";
    parameter = [parameter appendingWithValue:bid key:@"bid"];
    parameter = [parameter appendingWithValue:sid key:@"sid"];
    parameter = [parameter appendingWithValue:mid key:@"mid"];
    parameter = [parameter appendingWithValue:Id key:@"id"];
    parameter = [parameter appendingWithValue:iOrder key:@"iOrder"];
    parameter = [parameter appendingWithPage:p sum:s];
    return [self stringForCommonServiceWithAct:parameter];
}

+ (NSString *)url_reputationlistWithSid:(NSString *)sid
                                 iOrder:(NSString *)iOrder
                                      p:(NSInteger)p
                                      s:(NSInteger)s{
    return [self url_reputationlistWithBid:nil
                                       sid:sid
                                       mid:nil
                                        ID:nil
                                    iOrder:iOrder
                                         p:p
                                         s:s];
}

+ (NSString *)url_s_reputationWithSid:(NSString *)sid{
    NSString *parameter = @"act=s_reputation";
    parameter = [parameter appendingWithValue:sid key:@"sid"];
    return [self stringForCommonServiceWithAct:parameter];
}

/**发现-口碑 - 评论列表*/
+ (NSString *)url_reputationPLWithID:(NSString *)Id
                                   p:(NSInteger)p
                                   s:(NSInteger)s{
    NSString *parameter = @"act=reputationPL";
    parameter = [parameter appendingWithValue:Id key:@"id"];
    parameter = [parameter appendingWithPage:p sum:s];
    return [self stringForCommonServiceWithAct:parameter];
}

/**发现-口碑 - 评论*/
+ (NSString *)url_reputationReplyWithID:(NSString *)Id{
    NSString *parameter = @"act=reputationReply";
    parameter = [parameter appendingWithValue:Id key:@"id"];
    return [self stringForCommonServiceWithAct:parameter];
}


#pragma mark - 投诉
/**投诉列表*/
+ (NSString *)url_complainlistWithTitle:(NSString *)title
                                    sid:(NSString *)sid
                                      p:(NSInteger)p
                                      s:(NSInteger)s{
    NSString *parameter = @"act=complainlist";
    parameter = [parameter appendingWithValue:title key:@"title"];
    parameter = [parameter appendingWithValue:sid key:@"id"];
    parameter = [parameter appendingWithPage:p sum:s];
    return [self stringForCommonServiceWithAct:parameter];
}

/**根据车型获取投诉列表*/
+ (NSString *)url_complainlistWithSid:(NSString *)sid
                                    p:(NSInteger)p
                                    s:(NSInteger)s{
    return [self url_complainlistWithTitle:nil sid:sid p:p s:s];
}

/**投诉搜索*/
+ (NSString *)url_complainListWithTitle:(NSString *)title
                                      p:(NSInteger)p
                                      s:(NSInteger)s;{
    return [self url_complainlistWithTitle:title sid:nil p:p s:s];

}

/**投诉列表->投诉详情*/
+ (NSString *)url_complaininfoWithId:(NSString *)Id{
    NSString *parameter = @"act=complaininfo";
    parameter = [parameter appendingWithValue:Id key:@"id"];
    return [self stringForCommonServiceWithAct:parameter];
}



/**城市*/
+ (NSString *)url_discityWithPid:(NSString *)pid{
    NSString *parameter = @"act=discity";
    parameter = [parameter appendingWithValue:pid key:@"pid"];
    return [self stringForCommonServiceWithAct:parameter];
}


/**经销商*/
+ (NSString *)url_disWithPid:(NSString *)pid
                         cid:(NSString *)cid
                         sid:(NSString *)sid{
    NSString *parameter = @"act=dis";
    parameter = [parameter appendingWithValue:pid key:@"pid"];
    parameter = [parameter appendingWithValue:cid key:@"cid"];
    parameter = [parameter appendingWithValue:sid key:@"sid"];
    return [self stringForCommonServiceWithAct:parameter];
}

/**获取用户信息*/
+ (NSString *)url_userWithUid:(NSString *)uid{
    NSString *parameter = @"act=user";
    parameter = [parameter appendingWithValue:uid key:@"uid"];
    return [self stringForCommonServiceWithAct:parameter];
}


/**提交、修改投诉*/
+ (NSString *)url_addcomplain{
    return [self stringForCommonServiceWithAct:@"act=addcomplain"];
}




/**答疑列表*/
+ (NSString *)url_zjdylistWithTitle:(NSString *)title
                                sid:(NSString *)sid
                                  t:(NSString *)t
                                  p:(NSInteger)p
                                  s:(NSInteger)s{
    NSString *parameter = @"act=zjdylist";
    parameter = [parameter appendingWithValue:title key:@"title"];
    parameter = [parameter appendingWithValue:sid key:@"sid"];
    parameter = [parameter appendingWithValue:t key:@"t"];
    parameter = [parameter appendingWithPage:p sum:s];
    return [self stringForCommonServiceWithAct:parameter];
}

/**根据车型获取答疑列表*/
+ (NSString *)url_zjdylistWithSid:(NSString *)sid
                                t:(NSString *)t
                             page:(NSInteger)page
                              sum:(NSInteger)sum{
    return [self url_zjdylistWithTitle:nil sid:sid t:t p:page s:sum];
}

/**答疑搜索*/
+ (NSString *)url_zjdylistWithTitle:(NSString *)title
                               page:(NSInteger)page
                                sum:(NSInteger)sum{
    return [self url_zjdylistWithTitle:title sid:nil t:nil p:page s:sum];
}
/**提问*/
+ (NSString *)url_editZJDY{
    return [self stringForCommonServiceWithAct:@"act=editZJDY"];
}

/**答疑详情*/
+ (NSString *)url_zjdyinfoWithId:(NSString *)Id{
    NSString *parameter = @"act=zjdyinfo";
    parameter = [parameter appendingWithValue:Id key:@"id"];
    return [self stringForCommonServiceWithAct:parameter];
}


#pragma mark - 评论列表
/**评论列表*/
+ (NSString *)url_plWithId:(NSString *)Id
                      type:(NSString *)type
                      page:(NSInteger)p
                       sum:(NSInteger)s{
    NSString *parameter = @"act=pl";
    parameter = [parameter appendingWithValue:Id key:@"id"];
    parameter = [parameter appendingWithValue:type key:@"type"];
    parameter = [parameter appendingWithPage:p sum:s];
    return [self stringForCommonServiceWithAct:parameter];
}


/**提交评论*/
+ (NSString *)url_addpl{
    return [self stringForCommonServiceWithAct:@"act=addpl"];
}


///**答疑评论详情*/
//+ (NSString *)urlStringForGetZJDY{
//    return [self stringWithBasic:@"act=getzjdy&id=%@"];
//}



#pragma mark - 个人中心
/**根据cpid获取投诉详情*/
+ (NSString *)url_tsdetailWithCpid:(NSString *)cpid{
    NSString *parameter = @"act=tsdetail";
    parameter = [parameter appendingWithValue:cpid key:@"cpid"];
    return  [self stringForCommonServiceWithAct:parameter];
}


/**根据id获取投诉信息*/
+ (NSString *)url_mytslistWithCpid:(NSString *)cpid{
    return [self url_mytslistWithCpid:cpid uid:nil page:0 sum:0];
}

/**个人中心我的投诉列表*/
+ (NSString *)url_mytslistWithUid:(NSString *)uid
                             page:(NSInteger)page
                              sum:(NSInteger)sum{
    return [self url_mytslistWithCpid:nil uid:uid page:page sum:sum];
}

+ (NSString *)url_mytslistWithCpid:(NSString *)cpid
                               uid:(NSString *)uid
                              page:(NSInteger)page
                               sum:(NSInteger)sum{
    NSString *parameter = @"act=mytslist";
    parameter = [parameter appendingWithValue:cpid key:@"cpid"];
    parameter = [parameter appendingWithValue:uid key:@"uid"];
    parameter = [parameter appendingWithPage:page sum:sum];
    return [self stringForCommonServiceWithAct:parameter];
}

/**个人中心*/
+ (NSString *)url_personalCountWithUid:(NSString *)uid{
    NSString *parameter = @"act=personalCount";
    parameter = [parameter appendingWithValue:uid key:@"uid"];
    return [self stringForCommonServiceWithAct:parameter];
}


/**我的提问*/
+ (NSString *)url_myzjdyWithUid:(NSString *)uid
                           page:(NSInteger)page
                            sum:(NSInteger)sum{
    NSString *parameter = @"act=myzjdy";
    parameter = [parameter appendingWithValue:uid key:@"uid"];
    parameter = [parameter appendingWithPage:page sum:sum];
    return [self stringForCommonServiceWithAct:parameter];
}

/**提交评分*/
+ (NSString *)url_complainscoreWithCpid:(NSString *)cpid
                                  score:(NSString *)score{
    NSString *parameter = @"act=complainscore";
    parameter = [parameter appendingWithValue:cpid key:@"cpid"];
    parameter = [parameter appendingWithValue:score key:@"score"];
    return [self stringForCommonServiceWithAct:parameter];
}


/**修改密码*/
+ (NSString *)url_updatepwdWithUid:(NSString *)uid
                            oldpwd:(NSString *)oldpwd
                            newpwd:(NSString *)newpwd{
    NSString *parameter = @"act=updatepwd";
    parameter = [parameter appendingWithValue:uid key:@"uid"];
    parameter = [parameter appendingWithValue:oldpwd key:@"oldpwd"];
    parameter = [parameter appendingWithValue:newpwd key:@"newpwd"];
    return [self stringForCommonServiceWithAct:parameter];
}

/** 找回密码*/
+ (NSString *)url_sendemailWithUsername:(NSString *)username
                                 origin:(NSString *)origin{
    NSString *parameter = @"act=sendemail";
    parameter = [parameter appendingWithValue:username key:@"username"];
    parameter = [parameter appendingWithValue:origin key:@"origin"];
    return [self stringForCommonServiceWithAct:parameter];
}


/**申请撤诉*/
+ (NSString *)url_cancelComplain{
    return [self stringForCommonServiceWithAct:@"act=cancelComplain"];
}

/**申请撤诉-原因选择列表*/
+ (NSString *)url_delComTypeList{
    return [self stringForCommonServiceWithAct:@"act=delComTypeList"];
}


/**查看撤诉未成功原因*/
+ (NSString *)url_delComNoReasonWithCpid:(NSString *)cpid{
    NSString *parameter = @"act=delComNoReason";
    parameter = [parameter appendingWithValue:cpid key:@"cpid"];
    return [self stringForCommonServiceWithAct:parameter];
}

/**提交用户信息*/
+ (NSString *)url_u_updateinfoWithUid:(NSString *)uid{
    NSString *parameter = @"act=u_updateinfo";
    parameter = [parameter appendingWithValue:uid key:@"uid"];
    return [self stringForCommonServiceWithAct:parameter];
   // return [self stringWithBasic:@"act=personalInfo&uid=%@&realname=%@&gender=%@&birth=%@&email=%@&mobile=%@&qq=%@&telephone=%@&bid=%@&bname=%@&sid=%@&sname=%@&mid=%@&mname=%@"];
}


/**我的评论*/
+ (NSString *)url_myplWithUid:(NSString *)uid
                         page:(NSUInteger)page
                          sum:(NSInteger)sum{
    NSString *parameter = @"act=mypl";
    parameter = [parameter appendingWithValue:uid key:@"uid"];
    parameter = [parameter appendingWithPage:page sum:sum];
    return [self stringForCommonServiceWithAct:parameter];
}


/**上传头像*/
+ (NSString *)url_uploadAvatarWithUid:(NSString *)uid{
    NSString *parameter = @"act=uploadAvatar";
    parameter = [parameter appendingWithValue:uid key:@"uid"];
    return [self stringForCommonServiceWithAct:parameter];
}

#pragma mark - 综述
/**车系综述 - 车型信息 评分*/
+ (NSString *)urlString_s_indexWithSid:(NSString *)sid{

    NSString *parameter = @"act=s_index";
    parameter = [parameter appendingWithValue:sid key:@"sid"];
    return [self stringForCommonServiceWithAct:parameter];
}

/**车系综述 - 车型信息 车型故障统计*/
+ (NSString *)urlString_s_index2WithSid:(NSString *)sid{
    NSString *parameter = @"act=s_index2";
    parameter = [parameter appendingWithValue:sid key:@"sid"];
    return [self stringForCommonServiceWithAct:parameter];
}

/**车型综述-投诉头部 满意度&回复率*/
+ (NSString *)url_s_complainWithSid:(NSString *)sid{
    NSString *parameter = @"act=s_complain";
    parameter = [parameter appendingWithValue:sid key:@"sid"];
    return [self stringForCommonServiceWithAct:parameter];
}

/**对比-车型参数*/
+ (NSString *)url_mConfig{
    return [self url_mConfigWithSid:nil mid:nil];
}

+ (NSString *)url_mConfigWithSid:(NSString *)sid
                             mid:(NSString *)mid{
    NSString *parameter = @"act=mConfig";
    parameter = [parameter appendingWithValue:sid key:@"sid"];
    parameter = [parameter appendingWithValue:mid key:@"mid"];
    return [self stringForCZWServiceWithAct:parameter];
}
/**对比-车型故障信息*/
+ (NSString *)url_dbInfoWithBid:(NSString *)bid
                            sid:(NSString *)sid
                            mid:(NSString *)mid{
    NSString *parameter = @"act=dbInfo";
    parameter = [parameter appendingWithValue:bid key:@"bid"];
    parameter = [parameter appendingWithValue:sid key:@"sid"];
    parameter = [parameter appendingWithValue:mid key:@"mid"];
    return [self stringForCZWServiceWithAct:parameter];
}


@end
