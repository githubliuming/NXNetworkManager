//
//  NXDownLoad.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NXRequset;

typedef void(^progressBlock)(double progress);

typedef void(^completionHandlerBlock)(NSURLResponse *responese,id responseObject,NSError * error, NXRequset * requset);

/**
 真正执行下载的类
 */
@interface NXDownLoad : NSObject


- (void)downLoad:(NXRequset *) requset
                 progress:(progressBlock) progress
        completionHandler:(completionHandlerBlock) completionBlock;

- (void)resume;

- (void)suspend;

- (void)cancel;
@end
