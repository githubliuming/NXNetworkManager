//
//  NXBridge.h
//  NXNetworkManager
//
//  Created by 明刘 on 2017/9/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NXCompleteBlcok)(id responseObject, NSError *error);

@class NXRequest;
@interface NXBridge : NSObject

+ (instancetype)brige;
+ (instancetype) shareInstaced;


/**
 
发起请求
 @param request 请求对象
 @param completionHandler 结果回调
 */
-(void)sendWithRequst:(NXRequest *)request completionHandler:(NXCompleteBlcok)completionHandler;

/**
 
通过请求目标的 identifier 获取对应的request对象
 
 @param identifier 请求的目标 identifier
 @return 对应request对象
 */
- (NXRequest *)getRequestByIdentifier:(NSString *)identifier;


/**
 取消请求

 @param identifier 取消的请求目标的 identifier
 @return 取消的request
 */
- (NXRequest *)cancleRequst:(NSString *)identifier;

/**
 暂停请求

 @param identifier  暂停请求的目标 identifier
 */
- (void)pauseRequest:(NSString *)identifier;

/**
 恢复请求

 @param identifier 恢复的请求目标的 identifier
 */
- (void)resumeRequest:(NSString *)identifier;


#pragma mark - 证书模块
- (void)addSSLPinningURL:(NSString *)url;

- (void)addSSLPinningCert:(NSData *)cert;

- (void)addTwowayAuthenticationPKCS12:(NSData *)p12 keyPassword:(NSString *)password;

@end
