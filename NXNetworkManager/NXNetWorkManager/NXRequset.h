//
//  NXRequset.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXConstant.h"

@class NXConfig;
/**
 Http requset
 */
@interface NXRequset : NSObject

- (instancetype) initWithUrl:(NSString * )url;
- (instancetype) initWithAPIPath:(NSString *)apiPath;
/**
 请求url，当url有值且全局配置的BaseUrl也有值 并且ingoreBaseUrl为NO的情况下 以全局配置的url为准
 */
@property(nonatomic,strong)NSString * url;
/**
 接口路径
 */
@property(nonatomic,strong)NSString * apiPath;

/**
 接口完整路径
 */
@property(nonatomic,strong)NSString * fullPath;

/**
 是否忽略全局配置中的 baseUrl。默认NO 不忽略
 */
@property(nonatomic,assign)BOOL ingoreBaseUrl;

/**
 本次请求是否忽略默认配置的httpHeader  默认为NO 不忽略
 */
@property(nonatomic,assign) BOOL ingoreDefaultHttpHeaders;

/**
 本次请求是否忽略默认配置的请求参数 默认为NO 不忽略
 */
@property(nonatomic,assign) BOOL ingoreDefaultHttpParams;
/**
 上传 或者 下载文件存放的路径
 */
@property(nonatomic,strong) NSString * fileUrl;
/**
 http 请求参数信息
 */
@property(nonatomic,strong)id<NXContainerProtol> params;

/**
 http 请求头信息
 */
@property(nonatomic,strong)id<NXContainerProtol> headers;


/**
 requset请求的全局配置信息。 携带公共请求头、请求参数、baseUrl
 */
@property(nonatomic,strong)NXConfig  *config;


/**
 缓存策略 默认 NSURLRequestUseProtocolCachePolicy；
 */
@property(nonatomic,assign) NSURLRequestCachePolicy  cachePolicy;

/**
 请求ID
 */
@property(nonatomic,strong)NSString * identifier;


/**
 请求的类型，默认 NXRequestTypeNormal(包含 get、post...)
 */
@property(nonatomic,assign)NXRequestType * requstType;


/**
 取消当前请求
 */
- (void)cancelRequset;

- (void)addParams:(NXAddHeaderOrParamsBlock)params headers:(NXAddHeaderOrParamsBlock)headers;
- (void)addParams:(NXAddHeaderOrParamsBlock)params;
- (void)addHeaders:(NXAddHeaderOrParamsBlock)headers;


@end
