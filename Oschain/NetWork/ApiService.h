//
//  ApiService.h
//  SSBaseProject
//
//  Created by 王少帅 on 2018/1/30.
//  Copyright © 2018年 王少帅. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id data, NSString *needNotice);
typedef void(^FailBlock)(NSError *error);

typedef NS_ENUM(NSInteger, RequestType) {
    Request_Post,
    Request_Get,
};

typedef NS_ENUM(NSInteger, NetStatus) {
    NetStatus_Unknown,  //未知网络
    NetStatus_No,       //无网络
    NetStatus_WWAN,     //无线网卡,手机卡
    NetStatus_WiFi      //wifi
};

@interface ApiService : NSObject

@property (nonatomic, copy) NSString *token; //用户token
@property(nonatomic, assign) NetStatus netStatus;

+ (ApiService *)shareApiService;
- (void)saveToken:(NSString *)token;
- (void)clearToken;

// 通用网络请求
- (void)sendRequestType:(RequestType)requestType
                   page:(NSString *)page
                  param:(NSMutableDictionary *)param
              needToken:(BOOL)needToken
                success:(SuccessBlock)successBlock
                   fail:(FailBlock)failBlock;

//登录
- (void)loginByNumber:(NSString *)name
             Password:(NSString*)password
              success:(SuccessBlock)successBlock
                 fail:(FailBlock)failBlock;

@end
