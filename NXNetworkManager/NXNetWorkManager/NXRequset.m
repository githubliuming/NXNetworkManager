//
//  NXRequset.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXRequset.h"
#import "NXContainer.h"
#import "NXConfig.h"
@implementation NXRequset

- (instancetype) initWithUrl:(NSString * )url{

    self = [super init];
    if (self) {
        
        self.url = url;
        
        self.cachePolicy = NSURLRequestUseProtocolCachePolicy;
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

-(NSString *)fullPath{

    NSString * baseUrl = @"";
    if (self.ingoreBaseUrl) {
        
        baseUrl = self.url;
    }
    _fullPath = [NSString stringWithFormat:@"%@%@",baseUrl,self.apiPath];
    return _fullPath;
}
- (id<NXContainerProtol>) headers{
    
    if (!self.ingoreDefaultHttpHeaders) {
        //不忽略 合并请求头
        NXContainer * header = [[NXContainer alloc] init];
        NSDictionary * httpHeadDic = [_headers containerConfigDic];
        NSDictionary * defaultDic  = [self.config globalHeaders];
        
        [defaultDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            header.addString(obj,key);
        }];
        
        [httpHeadDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            header.addString(obj,key);
        }];
        
        return header;
    } else {
    
       return  _headers;
    }

}

- (id<NXContainerProtol>)params{

    if (!self.ingoreDefaultHttpParams) {
        //不忽略 合并请求参数
        NXContainer * paramContainer = [[NXContainer alloc] init];
        NSDictionary * httpParams = [_params containerConfigDic];
        NSDictionary * defaultDic = [self.config globalParams];
        [defaultDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            paramContainer.addString(obj,key);
        }];
        
        [httpParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            paramContainer.addString(obj,key);
        }];
        
        return paramContainer;
    } else {
    
        return _params;
    }
}


- (void)addParams:(NXAddHeaderOrParamsBlock)params headers:(NXAddHeaderOrParamsBlock)headers{

    if (params) {
        
        if (_params == nil) {
            
            _params = [[NXContainer alloc] init];
        }
        params(_params);
    }
    if (headers) {
        
        if (_headers ==nil) {
            
            _headers = [[NXContainer alloc] init];
        }
        
        headers(_headers);
    }
    
}
- (void)addParams:(NXAddHeaderOrParamsBlock)params{
    
    [self addParams:params headers:nil];

}
- (void)addHeaders:(NXAddHeaderOrParamsBlock)headers{

    [self addParams:nil headers:headers];
}

/**
 取消当前请求
 */
- (void)cancelRequset
{

    
}
- (void)start
{

    [self startWith:self.succesHandlerBlock failure:self.failureHandlerBlock];
}
- (void)startWith:(NXSuccesBlock) succes failure:(NXFailureBlock)failure{

    [self startWith:self.progressHandlerBlock success:succes failure:failure];
    
}
- (void)startWith:(NXProgressBlock)progress
          success:(NXSuccesBlock) succes
          failure:(NXFailureBlock)failure{

    
    
    [self setProgressHandlerBlock:progress];
    [self setSuccesHandlerBlock:succes];
    [self setFailureHandlerBlock:failure];
    
    //调用下层发起请求
}


- (void)clearHandlerBlock{

    self.progressHandlerBlock = NULL;
    self.failureHandlerBlock = NULL;
    self.succesHandlerBlock = NULL;
}

@end
