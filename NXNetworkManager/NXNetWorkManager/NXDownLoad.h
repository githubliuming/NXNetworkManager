//
//  NXDownLoad.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXConstant.h"

@interface NXDownLoad : NSObject


- (void)downLoad:(NXRequest *) requset
                 progress:(NXProgressBlock) progress
        completionHandler:(NXCompletionHandlerBlock) completionBlock;

- (void)resume;

- (void)suspend;

- (void)cancel;
@end
