//
//  ApiService.m
//  SSBaseProject
//
//  Created by 王少帅 on 2018/1/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import "ApiService.h"
#import <UICKeyChainStore/UICKeyChainStore.h>

#define Key_Token    @"token"

@interface ApiService ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation ApiService

+ (ApiService *)shareApiService
{
    static dispatch_once_t onceToken;
    static ApiService *instance;
    dispatch_once(&onceToken, ^{
        instance = [[ApiService alloc] init];
    });
    return instance;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager)
    {
        _manager = [AFHTTPSessionManager manager];
        /*
         *  请求格式
         *  AFHTTPRequestSerializer            二进制格式
         *  AFJSONRequestSerializer            JSON
         *  AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
         */
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //最大请求并发任务数
        _manager.operationQueue.maxConcurrentOperationCount = 5;
        // 设置请求头
//        [_manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
        // 设置接收的Content-Type
        _manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
        /*
         *  返回格式
         *  AFHTTPResponseSerializer           二进制格式
         *  AFJSONResponseSerializer           JSON
         *  AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
         *  AFXMLDocumentResponseSerializer (Mac OS X)
         *  AFPropertyListResponseSerializer   PList
         *  AFImageResponseSerializer          Image
         *  AFCompoundResponseSerializer       组合
         */
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 超时时间
        _manager.requestSerializer.timeoutInterval = 30.0f;
        //设置返回的content-type
        _manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];



    }
    return _manager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self monitorNetworkState];
        [self getSaveUser];
//        [[SDWebImageManager sharedManager].imageDownloader setValue:nil forHTTPHeaderField:@"Accept"];
    }
    return self;
}

- (void)getSaveUser
{
    NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
    self.token = [Defaults objectForKey:Key_Token];
}

#pragma mark 账号登录
- (void)loginByNumber:(NSString *)name Password:(NSString *)password success:(SuccessBlock)successBlock fail:(FailBlock)failBlock
{
    NSString *url = [self makeUrl:@"passport/login"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    param[@"homeSource"] = @"1";
    [param setObject:@"吴慧敏" forKey:@"userName"];
    [param setObject:@"whm1025" forKey:@"password"];
    
    [self.manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self doResponse:responseObject Success:^(id data, NSString *needNotice) {
            
            [self saveToken:[data objectForKey:@"token"]];
            UICKeyChainStore *keychainStore = [UICKeyChainStore keyChainStore];
            keychainStore[@"number"] = name;
            keychainStore[@"password"] = password;
            if (successBlock)
            {
                successBlock(data, nil);
            }
            
        } Fail:^(NSError *error) {
            
            if (failBlock)
            {
                failBlock(error);
            }
            
        }];
        
    } failure:^(NSURLSessionDataTask *task,NSError *error) {
        
        NSError *netError;
        netError = [NSError errorWithDomain:@"response" code:0 userInfo:@{NSLocalizedDescriptionKey:@"网络错误"}];
        if(failBlock)
        {
            failBlock(netError);
        }
        
    }];
}

#pragma mark - 通用网络请求
- (void)sendRequestType:(RequestType)requestType
                   page:(NSString *)page
                  param:(NSMutableDictionary *)param
              needToken:(BOOL)needToken
                success:(SuccessBlock)successBlock
                   fail:(FailBlock)failBlock;
{
    NSMutableDictionary *mutPara = [self signParametersWithParameters:param hasToken:needToken];
    
    if (requestType == Request_Post)
    {
        [self postRequestPage:page param:mutPara success:successBlock fail:failBlock];
    }
    else
    {
        [self getRequestPage:page param:mutPara success:successBlock fail:failBlock];
    }
}

#pragma mark 通用POST网络请求
- (void)postRequestPage:(NSString *)page
                  param:(NSMutableDictionary *)param
                success:(SuccessBlock)successBlock
                   fail:(FailBlock)failBlock;
{
    NSString *url = [self makeUrl:page];
    [self.manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask *task,id responseObject){
        
        [self doResponse:responseObject Success:successBlock Fail:failBlock];
        
    } failure:^(NSURLSessionDataTask *task,NSError *error) {
        
        NSError *netError;
        netError = [NSError errorWithDomain:@"response" code:0 userInfo:@{NSLocalizedDescriptionKey:@"网络错误"}];
        if(failBlock)
        {
            failBlock(netError);
        }
        
    }];
}

#pragma mark 通用GET网络请求
- (void)getRequestPage:(NSString *)page
                  param:(NSMutableDictionary *)param
                success:(SuccessBlock)successBlock
                   fail:(FailBlock)failBlock;
{
    NSString *url = [self makeUrl:page];
    [self.manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask *task,id responseObject){
        
        [self doResponse:responseObject Success:successBlock Fail:failBlock];
        
    } failure:^(NSURLSessionDataTask *task,NSError *error) {
        
        NSError *netError;
        netError = [NSError errorWithDomain:@"response" code:0 userInfo:@{NSLocalizedDescriptionKey:@"网络错误"}];
        if(failBlock)
        {
            failBlock(netError);
        }
        
     }];
}

#pragma mark - 数据解析
- (void)doResponse:(NSData *)data
           Success:(SuccessBlock)successBlock
              Fail:(FailBlock)failBlock
{
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (error)
    {
        if (failBlock)
        {
            error = [NSError errorWithDomain:@"response" code:0 userInfo:@{NSLocalizedDescriptionKey:@"数据格式错误"}];
            failBlock(error);
        }
    }
    else
    {
        if ([[json objectForKey:@"code"] integerValue] == 200)
        {
            if (successBlock)
            {
                successBlock([json objectForKey:@"data"], nil);
            }
        }
        else
        {
            error = [NSError errorWithDomain:@"response" code:[[json objectForKey:@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey:[json objectForKey:@"message"]}];
            if (failBlock)
            {
                failBlock(error);
            }
        }
    }
}

- (NSString *)makeUrl:(NSString *)page
{
    return [NSString stringWithFormat:@"%@%@", SERVER_ADDRESS, page];
}

- (void)saveToken:(NSString *)token
{
    self.token = token;
    [Tool saveToUserDefaultsValue:self.token forKey:Key_Token];
}

- (void)clearToken
{
    self.token = nil;
    [Tool saveToUserDefaultsValue:self.token forKey:Key_Token];
}

- (NSMutableDictionary *)signParametersWithParameters:(NSDictionary *)parameters hasToken:(bool)hasToken
{
    NSMutableDictionary *mutParam = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
//    [mutParam setObject:@"" forKey:@"appKey"];    //机型
//    [mutParam setObject:@"" forKey:@"timestamp"]; //时间戳
//    [mutParam setObject:@"" forKey:@"deviceId"];  //uuid
    if (hasToken) {
        [mutParam setObject:self.token forKey:@"token"];
    }
    //签名
//    NSString *sign = [Tool createMD5SignWithDictionary:mutParam];
//    [mutParam setObject:sign forKey:@"sign"];
    return mutParam;
}

#pragma mark 网络监测
- (void)monitorNetworkState
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                self.netStatus = NetStatus_Unknown;
                [Tool ShowMessage:@"未知网络" Lasttime:1.8];
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                self.netStatus = NetStatus_No;
                [Tool ShowMessage:@"无网络" Lasttime:1.8];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                self.netStatus = NetStatus_WWAN;
                [Tool ShowMessage:@"当前使用流量" Lasttime:1.8];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                self.netStatus = NetStatus_WiFi;
                [Tool ShowMessage:@"当前使用Wifi" Lasttime:1.8];
            }
                break;
            default:
                break;
        }
    }];
}


@end
