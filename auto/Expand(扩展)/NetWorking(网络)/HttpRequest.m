//
//  HttpRequest.m
//  12365auto
//
//  Created by bangong on 16/3/24.
//  Copyright © 2016年 车质网. All rights reserved.
//

#import "HttpRequest.h"
#import "AFNetworking.h"
#import <netinet/in.h>

#define kAFManger  [HttpRequest sharedInstance].afManger

@interface HttpRequest ()

@property (nonatomic, strong) AFHTTPSessionManager *afManger;

@end

@implementation HttpRequest

static HttpRequest *network = nil;
+ (instancetype)sharedInstance;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[HttpRequest alloc] init];
        network.afManger = [self sessionManager];
    });
    network.afManger.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    return network;
}

/**检测网络是否可用*/
+(BOOL) connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        // printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}



+ (AFHTTPSessionManager *)sessionManager{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml", @"image/*"]];
    manager.requestSerializer.timeoutInterval = 10;
    manager.operationQueue.maxConcurrentOperationCount = 2;
    return manager;
}

/**GET请求*/
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError * error))failure{
    NSLog(@"%@",URLString);
    //汉子编码处理
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //默认的缓存策略， 如果缓存不存在，直接从服务端获取。如果缓存存在，会根据response中的Cache-Control字段判断下一步操作，如: Cache-Control字段为must-revalidata, 则询问服务端该数据是否有更新，无更新的话直接返回给用户缓存数据，若已更新，则请求服务端.
    NSURLRequestCachePolicy policy = NSURLRequestUseProtocolCachePolicy;
    if ([self connectedToNetwork] == NO) {
        policy = NSURLRequestReturnCacheDataElseLoad;//取本地缓存
    }
    kAFManger.requestSerializer.cachePolicy = policy;

    NSURLSessionDataTask *task = [kAFManger GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success([self resetData:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    return task;
}

/**附带网络策略GET请求*/
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                       policy:(NSURLRequestCachePolicy)policy
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError * error))failure{

    //汉子编码处理
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    kAFManger.requestSerializer.cachePolicy = policy;
    
    NSURLSessionDataTask *task = [kAFManger GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success([self resetData:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    return task;
}

/**POST请求*/
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError * error))failure{
    //汉子编码处理
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    kAFManger.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    NSURLSessionDataTask *task = [kAFManger POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success([self resetData:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    return task;
}

/**上传单单张图片*/
+ (NSURLSessionDataTask *)POSTImage:(UIImage *)image
                                url:(NSString *)URLString
                           fileName:(NSString *)name
                         parameters:(NSDictionary *)parameters
                            success:(void (^)(id responseObject))success
                            failure:(void (^)(NSError * error))failure{
    //汉子编码处理
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    kAFManger.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    return  [kAFManger POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //
        NSData *data = UIImageJPEGRepresentation([self scaleToSize:image], 1);
        [formData appendPartWithFileData:data name:@"" fileName:name mimeType:@"image/jpg/file"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success([self resetData:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure (error);
    }];
}

/**批量上传图片*/
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                        images:(NSArray <__kindof UIImage *> *)images
                       success:(void (^)(id _Nullable responseObject))success
                       failure:(void (^)(NSError * _Nonnull error))failure{
  // URLString.UTF8String
    //汉子编码处理
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    kAFManger.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    NSURLSessionDataTask *task = [kAFManger POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0;i < images.count ; i++) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            
            NSString *name = [NSString stringWithFormat:@"%d",i];
            NSString *fileName = [NSString stringWithFormat:@"%@%d.jpg", str,i];
            NSData *date = UIImageJPEGRepresentation([self scaleToSize:images[i]], 1);
            [formData appendPartWithFileData:date name:name fileName:fileName mimeType:@"image/jpg/file"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success([self resetData:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    return task;
}


#pragma mark - 改变图片尺寸
+ (UIImage *)scaleToSize:(UIImage *)img{
    CGSize size = img.size;
    if (img.size.width <= size.width && img.size.height <= size.height){
        return img;
    }
    CGFloat maxXY = MAX(size.width, size.height);
    CGFloat xs = maxXY>700?700.0/maxXY:1;
    size = CGSizeMake(size.width*xs, size.height*xs);
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    img = nil;
    return scaledImage;
}

+ (NSDictionary *)resetData:(id)data{
    if (!data) {
        return nil;
    }
    if ([data isKindOfClass:[NSDictionary class]]) {
        return data;
    }else if ([data isKindOfClass:[NSArray class]]){
        if ([data count] == 0) {
            return [NSDictionary dictionary];
        }else if ([data count] == 1){
            NSDictionary *dict = data[0];
            if (dict[@"success"] || dict[@"error"]) {
                return dict;
            }else{
                return @{@"rel":data};
            }
        }else{
            return @{@"rel":data};
        }
    }

    return nil;
}

/**
 *  取消所有的网络请求
 */
+(void)cancelAllRequest
{
    [kAFManger.operationQueue cancelAllOperations];
}


/**
 *  取消指定的url请求
 *
 *  @param requestType 该请求的请求类型
 *  @param string      该请求的url
 */
+ (void)cancelHttpRequestWithRequestType:(NSString *)requestType
                       requestUrlString:(NSString *)string
{
    NSError * error;

    /**根据请求的类型 以及 请求的url创建一个NSMutableURLRequest---通过该url去匹配请求队列中是否有该url,如果有的话 那么就取消该请求*/

    NSString * urlToPeCanced = [[[kAFManger.requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];


    for (NSOperation * operation in kAFManger.operationQueue.operations) {

        //如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {

            //请求的类型匹配
            BOOL hasMatchRequestType = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];

            //请求的url匹配

            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];

            //两项都匹配的话  取消该请求
            if (hasMatchRequestType && hasMatchRequestUrlString) {

                [operation cancel];

            }
        }
    }
}

@end
