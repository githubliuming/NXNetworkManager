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


/**
 取消请求
 @param identifier 取消的请求目标的 identifier
 */
- (void)cancleRequest:(NSString *)identifier;

/**
 恢复请求

 @param identifier 恢复的请求目标的 identifier
 */
- (void)resumeRequest:(NSString *)identifier;

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
