//
//  NXNetWorkSession.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXNetWorkSession.h"
#import "AFNetworking.h"
#import "NXRequset.h"

@implementation NXNetWorkSession

+ (instancetype) shareInstanced{
    
    static NXNetWorkSession * nx_session = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        nx_session = [[NXNetWorkSession alloc] init];
    });
    return nx_session;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       
        self.requestTimeOut = 10.0f;
    }
    return self;
}

- (AFHTTPSessionManager *) AFSessionManager:(id<NXHttpHeaderContainerProtol>)header
{
    AFHTTPSessionManager * manager =  [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval  = self.requestTimeOut;
    if (header) {
        
        NSDictionary * headDic = header.headerInfoConfigDic;
        [headDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            [manager.requestSerializer setValue:obj forHTTPHeaderField:obj];
        }];
    }
    return manager;
    
}
- (void) Get:(NXRequset *)request success:(NXSuccesBlock) success failure:(NXFailureBlock)failureBlock {

    AFHTTPSessionManager *manager = [self AFSessionManager:request.headers];
    [manager GET:request.url parameters:request.params.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            success(task,responseObject,request);
        }
        [manager.session invalidateAndCancel];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failureBlock) {
            
            failureBlock(task,error,request);
        }
        [manager.session invalidateAndCancel];
    }];
    
}

- (void)post:(NXRequset *)request success:(NXSuccesBlock) success failure:(NXFailureBlock)failureBlock {
    
    AFHTTPSessionManager *manager = [self AFSessionManager:request.headers];
    [manager POST:request.url parameters:request.params.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(task,responseObject,request);
        }
        [manager.session invalidateAndCancel];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failureBlock) {
            
            failureBlock(task,error,request);
        }
        [manager.session invalidateAndCancel];
    }];
    
}

- (void) post:(NXRequset *)requset
formDataBlock:(NXFormDataBlock)formDatas
     progress:(NXProgressBlock)progress
      success:(NXSuccesBlock)succces
      failure:(NXFailureBlock) failure{

        AFHTTPSessionManager * manager = [self AFSessionManager:requset.headers];
    
        [manager POST:requset.url parameters:requset.params.params constructingBodyWithBlock:formDatas progress:^(NSProgress * _Nonnull uploadProgress) {
            
            if (progress) {
                
                progress(uploadProgress.fractionCompleted);
            }
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (succces) {
                
                succces(task,responseObject,requset);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failure) {
                failure(task,error,requset);
            }
        }];
    
}

- (void) uplaod:(NXRequset *)requset  progress:(NXProgressBlock) progress complentBlock:(NXCompletionHandlerBlock)completionHandler{

    AFHTTPSessionManager * manager = [self AFSessionManager:nil];
    NSURLRequest * urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:requset.url]];
    
    [manager uploadTaskWithRequest:urlRequest fromFile:[NSURL fileURLWithPath:requset.fileUrl] progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            progress(uploadProgress.fractionCompleted);
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (completionHandler) {
            
            completionHandler(response,responseObject,error,requset);
        }
    }];
}
@end
