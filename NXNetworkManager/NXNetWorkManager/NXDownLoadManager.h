//
//  NXDownLoadManager.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NXDownLoad.h"
#import "NXRequset.h"
/**
 下载管理类
 */
@interface NXDownLoadManager : NSObject

+ (instancetype) shareInstanced;
/**
 最大并发下载数目 ，默认值为 5
 */
@property(nonatomic,assign) NSInteger maxDownloadCount;

- (NSString *)downLoad:(NXRequset *) requset
              progress:(NXProgressBlock) progress
     completionHandler:(NXCompletionHandlerBlock) completionBlock;

- (void)cancelAllTask;
- (void)cancelTaskWithTaskId:(NSString *)taskId;

- (void)resumeAllTask;
- (void)resumeWithTaskId:(NSString *)taskId;

- (void)suspendAllTask;
- (void)suspendWithTaskid:(NSString *)taskId;

@end
