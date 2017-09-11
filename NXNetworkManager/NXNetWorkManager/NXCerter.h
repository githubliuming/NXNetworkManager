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

- (NSString *) sendRequset:(NXRequest *)requset;
- (NSString *) sendRequset:(NXRequest *)requset progress:(NXProgressBlock) progressBlock;
- (NSString *) sendRequset:(NXRequest *)requset succes:(NXSuccesBlock)succes failure:(NXFailureBlock)failure;
- (NSString *)sendRequset:(NXRequest *)requset progress:(NXProgressBlock) progressBlock
                   succes:(NXSuccesBlock) succes failure:(NXFailureBlock) failure;
@end
