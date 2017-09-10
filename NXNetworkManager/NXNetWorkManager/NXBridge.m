//
//  NXBridge.m
//  NXNetworkManager
//
//  Created by 明刘 on 2017/9/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXBridge.h"
#import "AFNetworking.h"
#import "NXRequset.h"
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

- (AFHTTPSessionManager * )sessionManagerWithRequset:(NXRequset *)request
{

    return self.sessionManager;
}

- (AFHTTPResponseSerializer *) resposeSerializerWithRequset:(NXRequset *)request{

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
- (AFHTTPRequestSerializer *) requestSerializerWithRequest:(NXRequset *)requset{
    
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

-(void)processUrlRequest:(NSMutableURLRequest *) urlRequest withNXRequset:(NXRequset *)request{

    NSDictionary * headerDic = [request.headers containerConfigDic];
    if (headerDic.count >0) {
        
        [headerDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            [urlRequest setValue:obj forHTTPHeaderField:key];
        }];
    }
    urlRequest.timeoutInterval = request.timeOutInterval;
}

-(void)sendWithRequst:(NXRequset *)requset{

    switch (requset.requstType) {
        case NXRequestTypeNormal:{
        
            [self nx_dataTaskWithRequest:requset];
        }break;
        case NXRequestTypeUpload:{
        
            [self nx_uploadTaskWithRequset:requset];
        }break;
        case kXMRequestDownload:{
            [self nx_downloadTastWithRequset:requset];
        }break;
        default:{
        
            NSAssert(NO, @"未知的请求类型");
        }
            break;
    }
}

- (void)nx_dataTaskWithRequest:(NXRequset *)requset
{
    static NSArray * httpMethodArray ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpMethodArray = @[@"GET",@"POST",@"HEAD",@"DELETE",@"PUT",@"PATCH"];
    });
    NSString * httpMethod;
    if (requset.httpMethod >= 0 && requset.httpMethod < httpMethodArray.count) {
        
        httpMethod = httpMethodArray[requset.httpMethod];
    }
    
    NSAssert(!httpMethod, @"当前 http 请求的类型 requset.httpMethod = %ld",(long)requset.httpMethod);
    AFHTTPSessionManager * sessionManager = [self sessionManagerWithRequset:requset];
    AFHTTPRequestSerializer * requestSerializer = [self requestSerializerWithRequest:requset];
    AFHTTPResponseSerializer * reposeSerializer = [self resposeSerializerWithRequset:requset];
    	
    NSError * urlRequstError;
    NSMutableURLRequest * urlRequst = [requestSerializer requestWithMethod:httpMethod URLString:requset.url parameters:requset.params.containerConfigDic error:&urlRequstError];
    if (urlRequstError) {
        if (requset.failureHandlerBlock) {
            dispatch_async(sessionManager.completionQueue, ^{
            
                requset.failureHandlerBlock(nil, urlRequstError, requset);
            });
            
        }
        return;
    }
    
    [self processUrlRequest:urlRequst withNXRequset:requset];
    NSURLSessionDataTask *dataTask = nil;
    __weak __typeof(self)weakSelf = self;
    dataTask = [sessionManager dataTaskWithRequest:urlRequst
                                 completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                     __strong __typeof(weakSelf)strongSelf = weakSelf;
//                                     [strongSelf xm_processResponse:response
//                                                             object:responseObject
//                                                              error:error
//                                                            request:request
//                                                  completionHandler:completionHandler];
                                 }];
    
    [dataTask resume];
}

-(void) nx_uploadTaskWithRequset:(NXRequset *)request{

    
}

-(void)nx_downloadTastWithRequset:(NXRequset *)requset{

    
}
@end
