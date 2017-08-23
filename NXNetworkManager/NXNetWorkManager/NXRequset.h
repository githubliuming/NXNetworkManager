//
//  NXRequset.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXNetWorkProtol.h"
/**
 Http requset
 */
@interface NXRequset : NSObject

- (instancetype) initWithUrl:(NSString * )url;

/**
 请求url
 */
@property(nonatomic,strong)NSString * url;

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
 缓存策略 默认 NSURLRequestUseProtocolCachePolicy；
 */
@property(nonatomic,assign) NSURLRequestCachePolicy  cachePolicy;


- (void)addParams:(NXAddHeaderOrParamsBlock)params headers:(NXAddHeaderOrParamsBlock)headers;
- (void)addParams:(NXAddHeaderOrParamsBlock)params;
- (void)addHeaders:(NXAddHeaderOrParamsBlock)headers;


@end
