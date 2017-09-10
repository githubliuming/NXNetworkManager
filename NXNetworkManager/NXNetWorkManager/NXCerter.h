//
//  NXCerter.h
//  NXNetworkManager
//
//  Created by 明刘 on 2017/9/9.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXConstant.h"
@class NXRequset;
@interface NXCerter : NSObject

- (NSString *) sendRequset:(NXRequset *)requset;
- (NSString *) sendRequset:(NXRequset *)requset progress:(NXProgressBlock) progressBlock;
- (NSString *) sendRequset:(NXRequset *)requset succes:(NXSuccesBlock)succes failure:(NXFailureBlock)failure;
- (NSString *)sendRequset:(NXRequset *)requset progress:(NXProgressBlock) progressBlock
                   succes:(NXSuccesBlock) succes failure:(NXFailureBlock) failure;
@end
