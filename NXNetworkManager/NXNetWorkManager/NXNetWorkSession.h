//
//  NXNetWorkSession.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NXRequset;

@interface NXNetWorkSession : NSObject

typedef void(^NXSuccesBlock)(NSURLSessionDataTask *task,id responseObject, NXRequset * requset);

typedef void (^NXFailureBlock)(NSURLSessionDataTask * task, NSError *error,NXRequset * requset);

+ (instancetype)shareInstanced;

/**
 设置请求超时时间 默认10s
 */
@property(nonatomic,assign) NSTimeInterval requestTimeOut;

- (void)Get:(NXRequset *)request
     success:(NXSuccesBlock) success
     failure:(NXFailureBlock)failureBlock;

- (void)post:(NXRequset *)request
     success:(NXSuccesBlock) success
     failure:(NXFailureBlock)failureBlock;
@end
