//
//  NXNetWorkSession.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXConstant.h"


@interface NXNetWorkSession : NSObject


+ (instancetype)shareInstanced;

/**
 设置请求超时时间 默认10s
 */
@property(nonatomic,assign) NSTimeInterval requestTimeOut;



/**
 向服务器发送Get请求

 @param request 请求requset
 @param success 成功回调
 @param failureBlock 失败回调
 */
- (void)Get:(NXRequest *)request
     success:(NXSuccesBlock) success
     failure:(NXFailureBlock)failureBlock;


/**
 向服务器发送 POST请求

 @param request 请求requset
 @param success 成功回调
 @param failureBlock 失败回调
 */
- (void)post:(NXRequest *)request
     success:(NXSuccesBlock) success
     failure:(NXFailureBlock)failureBlock;


#pragma mark - 文件上传

/**
 post 文件上传

 @param requset 请求requst
 @param formDatas 上传文件数据
 @param progress 上传进度
 @param succces 成功回调
 @param failure 失败回调
 */
- (void)post:(NXRequest *)requset
formDataBlock:(NXFormDataBlock)formDatas
     progress:(NXProgressBlock)progress
      success:(NXSuccesBlock)succces
      failure:(NXFailureBlock) failure;


/**
 上传本地文件

 @param requset 上传requst
 @param progress 进度回调
 @param completionHandler 结果回调
 */
- (void)uplaod:(NXRequest *)requset  progress:(NXProgressBlock) progress complentBlock:(NXCompletionHandlerBlock)completionHandler;

@end
