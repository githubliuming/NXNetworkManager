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

@interface NXCerter ()
@property(nonatomic,strong)NSMutableDictionary<NSString *,NXBatchRequest *> * batchRequestPool;
@property(nonatomic,strong) NSLock * lock;
@end
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

- (NSMutableDictionary<NSString *,NXBatchRequest *> * )batchRequestPool{

    if (_batchRequestPool == nil) {
        
        _batchRequestPool = [[NSMutableDictionary alloc] init];
    }
    
    return _batchRequestPool;
}
#pragma mark -
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
    //请求正式发起前的回调
    if (requset.requestProcessHandler) {
        
        requset.requestProcessHandler(requset);
    }
    //合并公共请求参数
    [self nx_processParams:requset];
    //合并公共请求头
    [self nx_processHeaders:requset];
    
    return  [self nx_sendRequest:requset];
}

-(void)nx_processParams:(NXRequest *)request{

    if (!request.ingoreDefaultHttpParams){
        //不忽略 合并请求参数
        NXContainer * paramContainer = [[NXContainer alloc] init];
        NSDictionary * httpParams = [request.headers containerConfigDic];
        NSDictionary * defaultDic = [request.config globalParams];
        [defaultDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            paramContainer.addString(obj,key);
        }];
        
        [httpParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            paramContainer.addString(obj,key);
        }];
        
        request.params = paramContainer;
    }
}

- (void)nx_processHeaders:(NXRequest *)request{

    if (!request.ingoreDefaultHttpHeaders) {
        //不忽略 合并请求头
        NXContainer * headers = [[NXContainer alloc] init];
        NSDictionary * httpHeadDic = [request.headers containerConfigDic];
        NSDictionary * defaultDic  = [request.config globalHeaders];
        
        [defaultDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            headers.addString(obj,key);
        }];
        
        [httpHeadDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            headers.addString(obj,key);
        }];
     
        request.headers = headers;
    }
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


#pragma mark - 批量处理模块
/**
 发起批量请求
 
 @param bRequest 请求request
 */
- (NSString * )sendBatchRequest:(NXBatchRequest *)bRequest{

    return [self sendBatchRequest:bRequest success:bRequest.successBlock failure:bRequest.failureBlock];
}


/**
 发起批量请求
 @param bRequest 请求request
 @param success 成功回调
 @param failure 失败回调
 */
- (NSString *)sendBatchRequest:(NXBatchRequest *)bRequest success:(NXBatchSuccessBlock)success failure:(NXBatchFailureBlock)failure{

    if(bRequest.requestPool.count > 0){
        [bRequest cleanCalbackHandler];
        bRequest.successBlock = success;
        bRequest.failureBlock = failure;
        [bRequest.requestPool removeAllObjects];
        
        for (NXRequest * requst in bRequest.requestPool) {
            [bRequest.responsePool addObject:[NSNull null]];
            __weak typeof(self) weakSelf = self;
            [requst startWith:^(id responseObject, NXRequest *rq) {
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf nx_processBatch:requst batchRequest:bRequest responseObj:nil error:nil];
                
            } failure:^(NSError *error, NXRequest *rq) {
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf nx_processBatch:requst batchRequest:bRequest responseObj:nil error:error];
            }];
        }
        [self.lock lock];
        NSString * identifier = [self nx_identifierForBatchAndChainRequest];
        bRequest.identifier = identifier;
        [self.batchRequestPool setObject:bRequest forKey:identifier];
        [self.lock unlock];
        return identifier;
    } else {
    
        return nil;
    }
    
}

- (void)nx_processBatch:(NXRequest*)request batchRequest:(NXBatchRequest *)bRequest responseObj:(id)response error:(NSError *)error{

    [self.lock lock];
    if ([bRequest onFinish:request reposeObject:response error:error]) {
        
        [self.batchRequestPool removeObjectForKey:bRequest.identifier];
    }
    [self.lock unlock];
    
}

- (NSString *)nx_identifierForBatchAndChainRequest{

    long long time = [[NSDate date] timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"BC%lld",time];
}

#pragma mark -
- (void)pasueRequest:(NSString *)identifier
{
    [[NXBridge shareInstaced] pauseRequest:identifier];
}
- (void)cancleRequest:(NSString *)identifier
{
    NXRequest * request = [[NXBridge shareInstaced] cancleRequst:identifier];
    [request clearHandlerBlock];
    
}
- (void)resumeRequest:(NSString *)identifier request:(NXRequest *)request{

    [[NXBridge shareInstaced] resumeRequest:identifier request:request];
}
- (id)getRequest:(NSString *)identifier{

    return [[NXBridge shareInstaced] getRequestByIdentifier:identifier];
}

- (void)addSSLPinningURL:(NSString *)url{

    [self.brdge addSSLPinningURL:url];
    
}
- (void)addSSLPinningCert:(NSData *)cert{

    [self.brdge addSSLPinningCert:cert];
}
- (void)addTwowayAuthenticationPKCS12:(NSData *)p12 keyPassword:(NSString *)password
{
    [self.brdge addTwowayAuthenticationPKCS12:p12 keyPassword:password];
}
@end
