//
//  CZWManager.h
//  chezhiwang
//
//  Created by bangong on 16/9/30.
//  Copyright © 2016年 车质网. All rights reserved.
//

#import <Foundation/Foundation.h>


#define CZWManagerInstance [CZWManager manager]
@interface CZWManager : NSObject

@property (nonatomic,assign,readonly) BOOL isLogin;
@property (nonatomic,copy,readonly) NSString *userName;
@property (nonatomic,copy,readonly) NSString *password;
@property (nonatomic,copy,readonly) NSString *userID;
@property (nonatomic,copy,readonly) NSString *iconUrl;

/**登录账号*/
- (void)loginWithDictionary:(NSDictionary *)dictionary;
/**存储密码*/
- (void)storagePassword:(NSString *)password;
/**更新头像地址*/
- (void)updateIconUrl:(NSString *)url;
/**退出账号*/
- (void)logoutAccount;


#pragma mark - class method
/***/
+ (CZWManager *)manager;
/**默认展示图片*/
+ (UIImage *)defaultIconImage;

+ (NSString *)get_userID;
@end
