//
//  NXRequset.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXRequset.h"
#import "NXHeaderAndParamsConfig.h"
#import "NXContainer.h"
@implementation NXRequset

- (instancetype) initWithUrl:(NSString * )url{

    self = [super init];
    if (self) {
        
        self.url = url;
        
        self.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return self;
    
}
- (instancetype)init
{
    return [self initWithUrl:@""];
}

- (id<NXContainerProtol>) headers{
    
    if (!self.ingoreDefaultHttpHeaders) {
        //不忽略 合并请求头
        NXContainer * header = [[NXContainer alloc] init];
        NSDictionary * httpHeadDic = [_headers containerConfigDic];
        NSDictionary * defaultDic  = [NXHeaderAndParamsConfig shareInstanceted].headerInfoConfigDic;
        
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
        NSDictionary * defaultDic = [[NXHeaderAndParamsConfig shareInstanceted] params];
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

@end
