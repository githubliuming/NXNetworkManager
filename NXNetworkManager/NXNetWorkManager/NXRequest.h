//
//  NXRequest.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXConstant.h"

@class NXConfig;
@class NXUploadFormData;
/**
 Http requset
 */
@interface NXRequest : NSObject

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
 超时时间
 */
@property(nonatomic,assign) NSTimeInterval  timeOutInterval;

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
@property(nonatomic,assign)NXRequestType  requstType;


/**
 请求方法 GET POST
 */
@property(nonatomic,assign) NXHTTPMethodType httpMethod;

/**
 requst content-type
 */
@property(nonatomic,assign) NXRequstSerializerType  requstSerializer;

/**
 respose content-type
 */
@property(nonatomic,assign) NXResposeSerializerType resopseSerializer;
/**
 请求失败回调方法
 */
@property(nonatomic,copy) NXFailureBlock  failureHandlerBlock;

/**
  请求成功回调
 */
@property(nonatomic,copy) NXSuccesBlock   succesHandlerBlock;

/**
 进度回调
 */
@property(nonatomic,copy) NXProgressBlock progressHandlerBlock;


/**
 上传文件数组
 */
@property(nonatomic,strong)NSMutableArray <NXUploadFormData *> * uploadFileArray;

/**
 开始发起请求
 @param progress 进度block
 @param succes 成功回调block
 @param failure 失败回调
 */
- (void)startWith:(NXProgressBlock)progress success:(NXSuccesBlock) succes failure:(NXFailureBlock)failure;


/**
 开始发起请求

 @param succes 成功回调
 @param failure 失败回调
 */
- (void)startWith:(NXSuccesBlock) succes failure:(NXFailureBlock)failure;
/**
 开始发起请求
 */
- (void)start;

/**
 取消当前请求
 */
- (void)cancelRequset;

/**
 清空 回调block避免循环引用
 */
- (void)clearHandlerBlock;

/**
 添加 请求参数和请求头

 @param params 添加请求参数block
 @param headers 添加请求头的block
 */
- (void)addParams:(NXAddHeaderOrParamsBlock)params headers:(NXAddHeaderOrParamsBlock)headers;

/**
 向 requset添加请求参数
 
 @param params 请求参数block
 */
- (void)addParams:(NXAddHeaderOrParamsBlock)params;

/**
 
向 request添加请求头
 @param headers 请求头block
 */
- (void)addHeaders:(NXAddHeaderOrParamsBlock)headers;

- (void)addFormDataWithName:(NSString *)name fileData:(NSData *)fileData;
- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData;
- (void)addFormDataWithName:(NSString *)name fileURL:(NSURL *)fileURL;
- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileURL:(NSURL *)fileURL;

@end


/**
  上传时 填充表单的文件数据类
 */
@interface NXUploadFormData : NSObject

@property(nonatomic,copy)   NSString * name;
@property(nonatomic,copy)   NSString * fileName;
@property(nonatomic,copy)   NSString * mimeType;
@property(nonatomic,strong) NSData * fileData;
@property(nonatomic,strong) NSURL * fileUrl;

+ (instancetype)formDataWithName:(NSString *)name fileData:(NSData *)fileData;
+ (instancetype)formDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData;
+ (instancetype)formDataWithName:(NSString *)name fileURL:(NSURL *)fileURL;
+ (instancetype)formDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileURL:(NSURL *)fileURL;
@end
