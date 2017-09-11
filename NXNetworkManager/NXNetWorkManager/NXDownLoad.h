//
//  NXDownLoad.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXConstant.h"
@class AFURLSessionManager;
@interface NXDownLoad : NSObject

@property (nonatomic, strong) AFURLSessionManager *manager;

- (NSURLSessionDataTask *)downLoad:(NXRequest *) requset
                 progress:(NXProgressBlock) progress
        completionHandler:(NXCompletionHandlerBlock) completionBlock;

@end
