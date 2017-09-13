//
//  NXRequest.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXRequest.h"
#import "NXConfig.h"
#import "NXCerter.h"

@interface NXRequest (){

    NSString * _fullUrl;
}

@end

@implementation NXRequest

- (instancetype) initWithUrl:(NSString * )url{

    self = [super init];
    if (self) {
        
        self.url = url;
        
        self.cachePolicy = NSURLRequestUseProtocolCachePolicy;
        self.requstSerializer = NXHTTPRrequstSerializerTypeJSON;
        self.resopseSerializer = NXHTTResposeSerializerTypeJSON;
        
    }
    return self;
    
}

- (instancetype) initWithAPIPath:(NSString *)apiPath{

    self = [self initWithUrl:nil];
    if (self) {
        
        self.apiPath = apiPath;
    }
    
    return self;
}
- (instancetype)init
{
    return [self initWithUrl:@""];
}

- (NSMutableArray<NXUploadFormData *> *) uploadFileArray{

    if (_uploadFileArray == nil) {
        
        _uploadFileArray = [[NSMutableArray alloc] init];
    }
    
    return _uploadFileArray;
}


/**
 获取最终生效的请求url, 当baseUrl 和 url同时设置时，根据 ingoreBaseUrl 字段返回url

 @return 请求的url
 */
- (NSString *)url{
    
    if (!self.ingoreBaseUrl) {
        
        _url = self.config.baseUrl;
    }
    return _url;
}

/**
 获取请求完整的url， url + APiUrl

 @return 拼接的完整url
 */
-(NSString *)fullUrl{

    NSString * baseUrl = self.config.baseUrl;
    if (self.ingoreBaseUrl) {
        
        baseUrl = self.url;
    }
    if (self.apiPath.length > 0) {
        
        if ([baseUrl hasSuffix:@"/"])
        {
            if ([self.apiPath hasPrefix:@"/"]) {
                NSString * tmpApi = [self.apiPath substringFromIndex:1];
                _fullUrl = [NSString stringWithFormat:@"%@%@",baseUrl,tmpApi];
            } else {
            
                _fullUrl = [NSString stringWithFormat:@"%@%@",baseUrl,self.apiPath];
            }
            
        } else {
            
            if ([self.apiPath hasPrefix:@"/"]) {
                _fullUrl = [NSString stringWithFormat:@"%@%@",baseUrl,self.apiPath];
            } else {
            _fullUrl = [NSString stringWithFormat:@"%@/%@",baseUrl,self.apiPath];
            }
        }
    } else {
    
        _fullUrl = [NSString stringWithFormat:@"%@",baseUrl];
    }
    return _fullUrl;
}

/**
 完整的请求头。 返回的 header容器里面已经包含了公共请求头参数

 @return 包含完整请求头信息的容器
 */
- (id<NXContainerProtol>) headers{
    
    if(_headers == nil){
    
        _headers = [[NXContainer alloc] init];
    }

    return _headers;
}

/**
 
 完整的请求参数。返回的params中已经包含设置的公共请求参数
 @return 完整的请求参数容器
 */
- (id<NXContainerProtol>)params{
    
    if (_params == nil) {
        
        _params = [[NXContainer alloc] init];
    }
    
    return _params;
}


///**
// 添加请求参数和请求头的方法
//
// @param params 请求参数block
// @param headers 请求头block
// */
//- (void)addParams:(NXAddHeaderOrParamsBlock)params headers:(NXAddHeaderOrParamsBlock)headers{
//
//    if (params) {
//        
//        if (_params == nil) {
//            
//            _params = [[NXContainer alloc] init];
//        }
//        params(_params);
//    }
//    if (headers) {
//        
//        if (_headers ==nil) {
//            
//            _headers = [[NXContainer alloc] init];
//        }
//        
//        headers(_headers);
//    }
//    
//}
//
///**
// 向 requset添加请求参数
// 
// @param params 请求参数block
// */
//- (void)addParams:(NXAddHeaderOrParamsBlock)params{
//    
//    [self addParams:params headers:nil];
//
//}
///**
// 
// 向 request添加请求头
// @param headers 请求头block
// */
//- (void)addHeaders:(NXAddHeaderOrParamsBlock)headers{
//
//    [self addParams:nil headers:headers];
//}

/**
 取消当前请求
 */
- (void)cancelRequset
{
    [[NXCerter shareInstanced] cancleRequest:self.identifier];
    [self clearHandlerBlock];
}

/**
 暂停请求
 */
- (void)pauseRequest
{
    [[NXCerter shareInstanced] pasueRequest:self.identifier];
}

/**
 恢复请求
 */
- (void)resumeRequst
{
    [[NXCerter shareInstanced] resumeRequest:self.identifier request:self];
}

/**
 准备发送请求
 */
- (void)start
{

    [self startWith:self.succesHandlerBlock failure:self.failureHandlerBlock];
}

/**
 准备发送请求

 @param succes 成功回调
 @param failure 失败回调
 */
- (void)startWith:(NXSuccesBlock) succes failure:(NXFailureBlock)failure{

    [self startWith:self.progressHandlerBlock success:succes failure:failure];
    
}

/**
 准备发送请求

 @param progress 进度回调
 @param succes 成功回调
 @param failure 失败回调
 */
- (void)startWith:(NXProgressBlock)progress
          success:(NXSuccesBlock) succes
          failure:(NXFailureBlock)failure{

    [self setProgressHandlerBlock:progress];
    [self setSuccesHandlerBlock:succes];
    [self setFailureHandlerBlock:failure];
    [[NXCerter shareInstanced] sendRequset:self];
}


/**
 释放掉当前对象的block，防止循环引用。(该方法在请求成功、失败后会自动调用)
 */
- (void)clearHandlerBlock
{
    self.progressHandlerBlock = nil;
    self.failureHandlerBlock = nil;
    self.succesHandlerBlock = nil;
    self.requestProcessHandler = nil;
    self.responseProcessHandler = nil;
}

- (void)addFormDataWithName:(NSString *)name fileData:(NSData *)fileData{

    NXUploadFormData * formData =[NXUploadFormData formDataWithName:name fileData:fileData];
    [self.uploadFileArray addObject:formData];
}
- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData{

    NXUploadFormData * formData  = [NXUploadFormData formDataWithName:name fileName:fileName mimeType:mimeType fileData:fileData];
    [self.uploadFileArray addObject:formData];
}
- (void)addFormDataWithName:(NSString *)name fileURL:(NSURL *)fileURL{

    NXUploadFormData * formData = [NXUploadFormData formDataWithName:name fileURL:fileURL];
    [self.uploadFileArray addObject:formData];
}
- (void)addFormDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileURL:(NSURL *)fileURL{

    NXUploadFormData * formData = [NXUploadFormData formDataWithName:name fileName:fileName mimeType:mimeType fileURL:fileURL];
    [self.uploadFileArray addObject:formData];
}

@end

@implementation NXUploadFormData


+ (instancetype)formDataWithName:(NSString *)name fileData:(NSData *)fileData{

    NXUploadFormData * formData = [[NXUploadFormData alloc] init];
    formData.name = name;
    formData.fileData = fileData;
    return formData;
}
+ (instancetype)formDataWithName:(NSString *)name fileURL:(NSURL *)fileURL{
    
    NXUploadFormData * formData = [[NXUploadFormData alloc] init];
    formData.name = name;
    formData.fileUrl = fileURL;
    return formData;

}
+ (instancetype)formDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileData:(NSData *)fileData{
    NXUploadFormData * uploadFormData = [[NXUploadFormData alloc] init];
    uploadFormData.name = name;
    uploadFormData.fileName = fileName;
    uploadFormData.mimeType = mimeType;
    uploadFormData.fileData = fileData;
    return uploadFormData;
}
+ (instancetype)formDataWithName:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType fileURL:(NSURL *)fileURL{
    NXUploadFormData * uploadFormData = [[NXUploadFormData alloc] init];
    
    uploadFormData.name = name;
    uploadFormData.fileName = fileName;
    uploadFormData.mimeType = mimeType;
    uploadFormData.fileUrl = fileURL;
    return uploadFormData;
}

@end

@interface NXBatchRequest ()

@property(nonatomic,strong) NSLock * lock;
@property(nonatomic,assign) NSInteger finishCount;
@property(nonatomic,assign) BOOL isFailure;
@end


@implementation NXBatchRequest

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.lock = [[NSLock alloc] init];
        self.isFailure = NO;
        self.finishCount = 0;
    }
    return self;
}
- (NSMutableArray *)responsePool{

    if (_requestPool == nil) {
        
        _requestPool = [[NSMutableArray alloc] init];
    }
    
    return _responsePool;
}

- (NSMutableArray<NXRequest *> *)requestPool
{
    if (_requestPool == nil) {
        
        _requestPool = [[NSMutableArray alloc] init];
    }
    
    return  _requestPool;
}

- (BOOL)onFinish:(NXRequest *)request reposeObject:(id)reposeObject error:(NSError * )error{

    [self.lock lock];
    BOOL isFinish = NO;
    NSInteger index = [self.requestPool indexOfObject:request];
    if (reposeObject)
    {
        [self.responsePool replaceObjectAtIndex:index withObject:reposeObject];
    } else {
    
        self.isFailure = YES;
        if (error) {
            
            [self.responsePool replaceObjectAtIndex:index withObject:error];
        }
    }
    self.finishCount +=1;
    
    if (self.finishCount == self.requestPool.count) {
        
        if (self.isFailure) {
            //整组失败
            if (self.failureBlock) {
                self.failureBlock(self.responsePool);
            }
        } else {
            //整组成功
            if (self.successBlock) {
                self.successBlock(self.responsePool);
            }
        }
        [self cleanCalbackHandler];
        isFinish = YES;
    }
    [self.lock unlock];
    
    return isFinish;
}

- (void)cleanCalbackHandler
{

    self.failureBlock = nil;
    self.successBlock = nil;
}

-(void)start:(NXBatchSuccessBlock) success failure:(NXBatchFailureBlock)failure{


}
- (void)addRequests:(NXAddBatchRequestBlock)bactchRequestBlock{

    if (bactchRequestBlock)
    {
        bactchRequestBlock(self.requestPool);
    }
}
@end
