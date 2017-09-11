//
//  NXBridge.m
//  NXNetworkManager
//
//  Created by 明刘 on 2017/9/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXBridge.h"
#import "AFNetworking.h"
#import "NXRequest.h"


@interface NXBridge()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) AFHTTPSessionManager *securitySessionManager;

@property (nonatomic, strong) AFHTTPRequestSerializer *afHTTPRequestSerializer;
@property (nonatomic, strong) AFJSONRequestSerializer *afJSONRequestSerializer;
@property (nonatomic, strong) AFPropertyListRequestSerializer *afPListRequestSerializer;

@property (nonatomic, strong) AFHTTPResponseSerializer *afHTTPResponseSerializer;
@property (nonatomic, strong) AFJSONResponseSerializer *afJSONResponseSerializer;
@property (nonatomic, strong) AFXMLParserResponseSerializer *afXMLResponseSerializer;
@property (nonatomic, strong) AFPropertyListResponseSerializer *afPListResponseSerializer;


@end
@implementation NXBridge

+(instancetype) brige{

    return [[[self class] alloc] init];
}

+(instancetype) shareInstaced{

    static NXBridge * nx_http_bridge = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        nx_http_bridge = [[NXBridge alloc] init];
    });
    
    return nx_http_bridge;
}
-(instancetype) init{

    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)dealloc{

    if (_sessionManager) {
        
        [_sessionManager invalidateSessionCancelingTasks:YES];
    }
    
    if (_sessionManager) {
        
        [_sessionManager invalidateSessionCancelingTasks:YES];
    }
}

- (AFHTTPSessionManager * )sessionManagerWithRequset:(NXRequest *)request
{

    return self.sessionManager;
}

- (AFHTTPResponseSerializer *) resposeSerializerWithRequset:(NXRequest *)request{

    AFHTTPResponseSerializer * responseSerializer = nil;
    switch (request.resopseSerializer) {
        case NXHTTResposeSerializerTypeRAW:{
        
             responseSerializer = self.afHTTPResponseSerializer;
        }break;
        case NXHTTResposeSerializerTypeXML:{
            responseSerializer = self.afXMLResponseSerializer;
        }break;
        case NXHTTResposeSerializerTypeJSON:{
        
            responseSerializer = self.afJSONResponseSerializer;
        }break;
        case NXHTTResposeSerializerTypePlist:{
            responseSerializer = self.afPListResponseSerializer;
        }break;
        default:
            break;
    }
    return responseSerializer;
}
- (AFHTTPRequestSerializer *) requestSerializerWithRequest:(NXRequest *)requset{
    
    AFHTTPRequestSerializer * requsetSirializer = nil;
    switch (requset.requstSerializer) {
        case NXHTTPRrequstSerializerTypeRAW:{
        
            requsetSirializer = self.afHTTPRequestSerializer;
        }break;
        case NXHTTPRrequstSerializerTypeJSON:{
        
            requsetSirializer = self.afJSONRequestSerializer;
        }break;
        case NXHTTPRrequstSerializerTypePlist:{
        
            requsetSirializer = self.afPListRequestSerializer;
        }break;
        default:
            break;
    }
    
    return requsetSirializer;
}
#pragma mark - Accessor

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer = self.afHTTPRequestSerializer;
        _sessionManager.responseSerializer = self.afHTTPResponseSerializer;
        _sessionManager.operationQueue.maxConcurrentOperationCount = 5;
//        _sessionManager.completionQueue = xm_request_completion_callback_queue();
    }
    return _sessionManager;
}

- (AFHTTPSessionManager *)securitySessionManager {
    if (!_securitySessionManager) {
        _securitySessionManager = [AFHTTPSessionManager manager];
        _securitySessionManager.requestSerializer = self.afHTTPRequestSerializer;
        _securitySessionManager.responseSerializer = self.afHTTPResponseSerializer;
        _securitySessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        _securitySessionManager.operationQueue.maxConcurrentOperationCount = 5;
//        _securitySessionManager.completionQueue = xm_request_completion_callback_queue();
    }
    return _securitySessionManager;
}

- (AFHTTPRequestSerializer *)afHTTPRequestSerializer {
    if (!_afHTTPRequestSerializer) {
        _afHTTPRequestSerializer = [AFHTTPRequestSerializer serializer];
        
    }
    return _afHTTPRequestSerializer;
}

- (AFJSONRequestSerializer *)afJSONRequestSerializer {
    if (!_afJSONRequestSerializer) {
        _afJSONRequestSerializer = [AFJSONRequestSerializer serializer];
        
    }
    return _afJSONRequestSerializer;
}

- (AFPropertyListRequestSerializer *)afPListRequestSerializer {
    if (!_afPListRequestSerializer) {
        _afPListRequestSerializer = [AFPropertyListRequestSerializer serializer];
    }
    return _afPListRequestSerializer;
}

- (AFHTTPResponseSerializer *)afHTTPResponseSerializer {
    if (!_afHTTPResponseSerializer) {
        _afHTTPResponseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _afHTTPResponseSerializer;
}

- (AFJSONResponseSerializer *)afJSONResponseSerializer {
    if (!_afJSONResponseSerializer) {
        _afJSONResponseSerializer = [AFJSONResponseSerializer serializer];
        _afJSONResponseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    }
    return _afJSONResponseSerializer;
}

- (AFXMLParserResponseSerializer *)afXMLResponseSerializer {
    if (!_afXMLResponseSerializer) {
        _afXMLResponseSerializer = [AFXMLParserResponseSerializer serializer];
    }
    return _afXMLResponseSerializer;
}

- (AFPropertyListResponseSerializer *)afPListResponseSerializer {
    if (!_afPListResponseSerializer) {
        _afPListResponseSerializer = [AFPropertyListResponseSerializer serializer];
    }
    return _afPListResponseSerializer;
}

-(void)processUrlRequest:(NSMutableURLRequest *) urlRequest withNXRequest:(NXRequest *)request{

    NSDictionary * headerDic = [request.headers containerConfigDic];
    if (headerDic.count >0) {
        
        [headerDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            [urlRequest setValue:obj forHTTPHeaderField:key];
        }];
    }
    urlRequest.timeoutInterval = request.timeOutInterval;
}

-(void)sendWithRequst:(NXRequest *)requset completionHandler:(NXCompleteBlcok)completionHandler{

    switch (requset.requstType) {
        case NXRequestTypeNormal:{
        
            [self nx_dataTaskWithRequest:requset completionHandler:completionHandler];
        }break;
        case NXRequestTypeUpload:{
        
            [self nx_uploadTaskWithRequset:requset completionHandler:completionHandler];
        }break;
        case kXMRequestDownload:{
            [self nx_downloadTastWithRequset:requset completionHandler:completionHandler];
        }break;
        default:{
        
            NSAssert(NO, @"未知的请求类型");
        }
            break;
    }
}

-(void)nx_dataTaskWithRequest:(NXRequest *)requst completionHandler:(NXCompleteBlcok)completionHandler
{
    static NSArray * httpMethodArray ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpMethodArray = @[@"GET",@"POST",@"HEAD",@"DELETE",@"PUT",@"PATCH"];
    });
    NSString * httpMethod;
    if (requst.httpMethod >= 0 && requst.httpMethod < httpMethodArray.count) {
        
        httpMethod = httpMethodArray[requst.httpMethod];
    }
    
    NSAssert(!httpMethod, @"当前 http 请求的类型 requset.httpMethod = %ld",(long)requst.httpMethod);
    AFHTTPSessionManager * sessionManager = [self sessionManagerWithRequset:requst];
    AFHTTPRequestSerializer * requestSerializer = [self requestSerializerWithRequest:requst];
    	
    NSError * urlRequstError;
    NSMutableURLRequest * urlRequst = [requestSerializer requestWithMethod:httpMethod URLString:requst.url parameters:requst.params.containerConfigDic error:&urlRequstError];
    if (urlRequstError) {
        if (requst.failureHandlerBlock) {
            dispatch_async(sessionManager.completionQueue, ^{
            
                requst.failureHandlerBlock(nil, urlRequstError, requst);
            });
            
        }
        return;
    }
    
    [self processUrlRequest:urlRequst withNXRequest:requst];
    NSURLSessionDataTask *dataTask = nil;
    __weak __typeof(self)weakSelf = self;
    
    dataTask = [sessionManager dataTaskWithRequest:urlRequst uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf nx_parseResponse:response responseObj:responseObject error:error request:requst completionHandler:completionHandler];
    }];
    
    [dataTask resume];
}

-(void) nx_uploadTaskWithRequset:(NXRequest *)request completionHandler:(NXCompleteBlcok)completionHandler{

    AFHTTPSessionManager * sessionManager = [self sessionManagerWithRequset:request];
    AFHTTPRequestSerializer * requestSerializer = [self requestSerializerWithRequest:request];
    
}

-(void)nx_downloadTastWithRequset:(NXRequest *)requset completionHandler:(NXCompleteBlcok)completionHandler{

    
    
}


- (void)nx_parseResponse:(NSURLResponse *)response responseObj:(id)responseObj error:(NSError *)error
                 request:(NXRequest *)request completionHandler:(NXCompleteBlcok) completeHandler{

    NSError * resposeSerializerError ;
    if(request.resopseSerializer != NXHTTPRrequstSerializerTypeRAW){
        AFHTTPResponseSerializer * serializer = [self resposeSerializerWithRequset:request];
        responseObj = [serializer responseObjectForResponse:response data:responseObj error:&resposeSerializerError];
        
        if (completeHandler) {
            
            if(resposeSerializerError){
            
                completeHandler(nil,resposeSerializerError);
            } else {
            
                completeHandler(responseObj,nil);
            }
        }
    }
}
- (void)nx_bindTask:(NXRequest *)requset dataTaskIdentifier:(NSUInteger)taskIdentifier sessionManager:(AFHTTPSessionManager *) sessionManager{

    NSString *identifier = nil;
    if ([sessionManager isEqual:self.sessionManager]) {
        identifier = [NSString stringWithFormat:@"+%lu", (unsigned long)taskIdentifier];
    } else if ([sessionManager isEqual:self.securitySessionManager]) {
        identifier = [NSString stringWithFormat:@"-%lu", (unsigned long)taskIdentifier];
    }
    [requset setValue:identifier forKey:@"_identifier"];
}
@end
