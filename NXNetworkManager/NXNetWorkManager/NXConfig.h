//
//  NXConfig.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/9/7.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXConstant.h"
@interface NXConfig : NSObject

- (instancetype)shareInstanced;
/**
 请求的baseUrl
 */
@property(nonatomic,strong) NSString *baseUrl;

/**
 https证书路径
 */
@property(nonatomic,strong)NSString * cerPath;


/**
 是否输出调试log
 */
@property (nonatomic, assign) BOOL consoleLog;


/**
 请求返回后的回调队列 默认主线程队列
 */
@property (nonatomic, strong) dispatch_queue_t callbackQueue;

/**
 添加公共请求参数
 @param params 回调block
 */
- (void)addParams:(NXAddHeaderOrParamsBlock)params;

/**
 
 添加公共请求头
 @param headers 回调block
 */
- (void)addHeaders:(NXAddHeaderOrParamsBlock)headers;

/**
 
 取出所有公共请参数
 @return 所有公共请参数
 */
- (NSDictionary *)globalParams;

/**
 
 取出所有的请求头
 @return 所有请求头
 */
- (NSDictionary *)globalHeaders;


- (void)addSSLPinningURL:(NSString *)url;
- (void)addSSLPinningCert:(NSData *)cert;
- (void)addTwowayAuthenticationPKCS12:(NSData *)p12 keyPassword:(NSString *)password;
@end


@interface NXContainer : NSObject<NXContainerProtol>

@end
