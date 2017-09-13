//
//  NXDownLoad.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXConstant.h"
@class AFHTTPSessionManager;
@interface NXDownLoad : NSObject


/**
 下载的session
 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;


/**
 开始执行下载文件

 @param requset 下载request
 @param progress 下载进度
 @param completionBlock 下载完成回调
 @return 下载任务的 NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)downLoad:(NXRequest *) requset
                 progress:(NXProgressBlock) progress
        completionHandler:(NXCompletionHandlerBlock) completionBlock;

- (void)resume;
@end
