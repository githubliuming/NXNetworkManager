//
//  NXCerter.m
//  NXNetworkManager
//
//  Created by 明刘 on 2017/9/9.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXCerter.h"
#import "NXRequest.h"
#import "NXBridge.h"
#import "NXConfig.h"
@implementation NXCerter

- (NXBridge *)brdge
{
    return [NXBridge shareInstaced];
}
+(instancetype) shareInstanced{

    static  NXCerter * nx_center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        nx_center = [[NXCerter alloc] init];
    });
    
    return nx_center;
}
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
    if (requset.requestProcessHandler) {
        
        requset.requestProcessHandler(requset);
    }
    return  [self nx_sendRequest:requset];
}

- (NSString *)nx_sendRequest:(NXRequest *)request{
    
    if (request.config.consoleLog) {
        
        if (request.requstType == NXRequestTypeDownload) {
            NSLog(@"\n============ [NXRequest Info] ============\nrequest download url: %@\nrequest save path: %@ \nrequest headers: \n%@ \nrequest parameters: \n%@ \n==========================================\n", request.fullUrl, request.fileUrl, request.headers.containerConfigDic, request.params.containerConfigDic);
        } else {
            NSLog(@"\n============ [NXRequest Info] ============\nrequest url: %@ \nrequest headers: \n%@ \nrequest parameters: \n%@ \n==========================================\n", request.fullUrl, request.headers.containerConfigDic, request.params.containerConfigDic);
        }
    }
    
    [self.brdge sendWithRequst:request completionHandler:^(id responseObject, NSError *error) {
        if (!error) {
            
            [self nx_succes:responseObject request:request];
        } else {
            
            [self nx_failure:error withRequest:request];
        }
    }];
    return request.identifier;
}
- (void)nx_succes:(id)reponseObj request:(NXRequest *)request
{
    NSError * error;
    if (request.requestProcessHandler) {
        request.responseProcessHandler(request, reponseObj, &error);
    }
    if(error)
    {
        [self nx_failure:error withRequest:request];
        return ;
    }
    if (request.config.consoleLog) {
        
        if (request.requstType == NXRequestTypeNormal) {
            
             NSLog(@"\n============ [NXResponse Data] ===========\nrequest download url: %@\nresponse data: %@\n==========================================\n", request.url, reponseObj);
            
        } else if (request.resopseSerializer == NXHTTResposeSerializerTypeRAW){
        
             NSLog(@"\n============ [NXResponse Data] ===========\nrequest url: %@ \nresponse data: \n%@\n==========================================\n", request.fullUrl, [[NSString alloc] initWithData:reponseObj encoding:NSUTF8StringEncoding]);
            
        } else {
        
            NSLog(@"\n============ [NXResponse Data] ===========\nrequest url: %@ \nresponse data: \n%@\n==========================================\n", request.url, reponseObj);
        }
    }
    __weak typeof(self) weakSelf = self;
    if (request.config.callbackQueue) {
     
        dispatch_async(request.config.callbackQueue, ^{
            
            __strong typeof(weakSelf) strongSelft = weakSelf;
            [strongSelft runSuccesHandler:reponseObj withRequest:request];
        });
    } else {
    
        [self runSuccesHandler:reponseObj withRequest:request];
    }
}

-(void)nx_failure:(NSError *)error withRequest:(NXRequest *)request{

    if (request.config.consoleLog) {
        
         NSLog(@"\n=========== [NXResponse Error] ===========\n request url: %@ \n error info: \n%@\n==========================================\n retyCount = %ld", request.url, error,(long)request.retryCount);
    }
    
    if (request.retryCount<= 0) {
     
        if (request.config.callbackQueue) {
            
            __weak typeof(self) weakSelf = self;
            dispatch_async(request.config.callbackQueue, ^{
                
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf runFailureHandler:error withRequest:request];
            });
        } else {
            
            [self runFailureHandler:error withRequest:request];
        }
        
    } else{
    
        //两秒后 自动调试
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self nx_sendRequest:request];
        });
    }
    
}
- (void)runFailureHandler:(NSError *)error withRequest:(NXRequest *)request{

    
    if (request.failureHandlerBlock) {
        
        request.failureHandlerBlock(error, request);
    }
    
    [request clearHandlerBlock];
}

-(void)runSuccesHandler:(id)resposeObj withRequest:(NXRequest *)request{

    if (request.succesHandlerBlock) {
        
        request.succesHandlerBlock(resposeObj, request);
    }
    [request clearHandlerBlock];
}

- (void)pasueRequest:(NSString *)identifier
{
    [[NXBridge shareInstaced] pauseRequest:identifier];
}
- (void)cancleRequest:(NSString *)identifier
{
    NXRequest * request = [[NXBridge shareInstaced] cancleRequst:identifier];
    [request clearHandlerBlock];
    
}
- (void)resumeRequest:(NSString *)identifier{

    [[NXBridge shareInstaced] resumeRequest:identifier];
}
- (id)getRequest:(NSString *)identifier{

    return [[NXBridge shareInstaced] getRequestByIdentifier:identifier];
}
@end
