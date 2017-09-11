//
//  NXCerter.m
//  NXNetworkManager
//
//  Created by 明刘 on 2017/9/9.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXCerter.h"
#import "NXRequest.h"
@implementation NXCerter
- (NSString *) sendRequset:(NXRequest *)requset{
    
    return [self sendRequset:requset progress:requset.progressHandlerBlock];
}
- (NSString *) sendRequset:(NXRequest *)requset progress:(NXProgressBlock) progressBlock
{
    return [self sendRequset:requset progress:progressBlock succes:requset.succesHandlerBlock failure:requset.failureHandlerBlock];
}
- (NSString *) sendRequset:(NXRequest *)requset succes:(NXSuccesBlock)succes failure:(NXFailureBlock)failure{

    return [self sendRequset:requset progress:requset.progressHandlerBlock succes:succes failure:failure];
}
- (NSString *)sendRequset:(NXRequest *)requset progress:(NXProgressBlock) progressBlock succes:(NXSuccesBlock) succes failure:(NXFailureBlock) failue{
    
    [requset clearHandlerBlock];
    requset.progressHandlerBlock = progressBlock;
    requset.succesHandlerBlock = succes;
    requset.failureHandlerBlock = failue;
    requset.identifier = @"";
    return requset.identifier;
}
@end
