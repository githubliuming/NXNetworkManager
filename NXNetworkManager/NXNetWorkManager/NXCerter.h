//
//  NXCerter.h
//  NXNetworkManager
//
//  Created by 明刘 on 2017/9/9.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXConstant.h"
@class NXRequest;
@class NXBatchRequest;
@class NXChainRequest;
@class NXBridge;
@interface NXCerter : NSObject


@property(nonatomic,strong,readonly)NXBridge * brdge;


+(instancetype) shareInstanced;


/**
 发起网络请求
 @param requset  请求request
 @return 本次request请求的 identifier
 */
- (NSString *) sendRequset:(NXRequest *)requset;

/**
 发起网络请求

 @param requset 请求request
 @param progressBlock 进度回调
 @return 本次request请求的 identifier
 */
- (NSString *) sendRequset:(NXRequest *)requset progress:(NXProgressBlock) progressBlock;

/**
 发起网络请求

 @param requset 请求request
 @param succes  请求成功回调
 @param failure 请求失败回调
 @return 本次request请求的 identifier
 */
- (NSString *) sendRequset:(NXRequest *)requset succes:(NXSuccesBlock)succes failure:(NXFailureBlock)failure;

/**
 发起网络请求

 @param requset  请求request
 @param progressBlock 进度回调
 @param succes 请求成功回调
 @param failure 请求失败回调
 @return 本次request请求的 identifier
 */
- (NSString *) sendRequset:(NXRequest *)requset progress:(NXProgressBlock) progressBlock
                   succes:(NXSuccesBlock) succes failure:(NXFailureBlock) failure;



#pragma mark -Batch 处理模块

/**
 发起批量请求

 @param bRequest 请求request
 */
- (NSString *)sendBatchRequest:(NXBatchRequest *)bRequest;


/**
 发起批量请求
 @param bRequest 请求request
 @param success 成功回调
 @param failure 失败回调
 */
- (NSString *)sendBatchRequest:(NXBatchRequest *)bRequest success:(NXBatchSuccessBlock)success failure:(NXBatchFailureBlock)failure;



#pragma mark -Chain 处理模块

/**
 发起链式请求

 @param chainRequet 请求 request
 @return 本次request请求的 identifier
 */
- (NSString *)sendChainRequst:(NXChainRequest *)chainRequet;

/**
 发起链式请求

 @param chainRequet 请求 request
 @param success 成功回调
 @param failure 失败回调
 @return 本次request请求的 identifier
 */
- (NSString *) sendChainRequest:(NXChainRequest *)chainRequet success:(NXChainSuccessBlock) success failure:(NXChainFailureBlock)failure;
/**
 取消请求
 @param identifier 取消的请求目标的 identifier
 */
- (void)cancleRequest:(NSString *)identifier;

/**
 恢复请求

 @param identifier 恢复的请求目标的 identifier
 */
- (void)resumeRequest:(NSString *)identifier request:(NXRequest *)request;

/**
 暂停请求

 @param identifier 暂停请求的目标 identifier
 */
- (void)pasueRequest:(NSString *)identifier;

/**
 通过请求目标的 identifier 获取对应的request对象

 @param identifier 请求的目标 identifier
 @return 对应request对象
 */
- (id)getRequest:(NSString *)identifier;

#pragma mark- 证书模块
- (void)addSSLPinningURL:(NSString *)url;
- (void)addSSLPinningCert:(NSData *)cert;
- (void)addTwowayAuthenticationPKCS12:(NSData *)p12 keyPassword:(NSString *)password;



@end
