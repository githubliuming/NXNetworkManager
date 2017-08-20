//
//  NXRequset.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXRequset.h"
#import "NXHeaderAndParamsConfig.h"
#import "NXParamContainer.h"
#import "NXRequestHeader.h"
@implementation NXRequset

- (instancetype) initWithUrl:(NSString * )url{

    self = [super init];
    if (self) {
        
        self.url = url;
    }
    return self;
    
}
- (instancetype)init
{
    return [self initWithUrl:@""];
}

- (id<NXHttpHeaderContainerProtol>) headers{
    
    if (!self.ingoreDefaultHttpHeaders) {
        //不忽略 合并请求头
        NXRequestHeader * header = [[NXRequestHeader alloc] init];
        NSDictionary * httpHeadDic = [_headers headerInfoConfigDic];
        NSDictionary * defaultDic  = [NXHeaderAndParamsConfig shareInstanceted].headerInfoConfigDic;
        
        [defaultDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            [header addString:obj forKey:key];
        }];
        
        [httpHeadDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            [header addString:obj forKey:key];
        }];
        
        return header;
    } else {
    
       return  _headers;
    }

}

- (id<NXParamContainerProtol>)params{

    if (!self.ingoreDefaultHttpParams) {
        //不忽略 合并请求参数
        NXParamContainer * paramContainer = [[NXParamContainer alloc] init];
        NSDictionary * httpParams = [_params params];
        NSDictionary * defaultDic = [[NXHeaderAndParamsConfig shareInstanceted] params];
        [defaultDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            [paramContainer addString:obj forKey:key];
        }];
        
        [httpParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            [paramContainer addString:obj forKey:key];
        }];
        
        return paramContainer;
    } else {
    
        return _params;
    }
}
- (void) addParams:(NXParamsBlock) params andHeaders:(NXHeadersBlock)headers{

    if (params) {
        
        self.params = [[NXParamContainer alloc] init];
        params(self.params);
    }
    
    if (headers) {
        
        self.headers = [[NXRequestHeader alloc] init];
        headers(self.headers);
    }
    
}
- (void) addParams:(NXParamsBlock) params{

    [self addParams:params andHeaders:nil];
}
- (void)addHeaders:(NXHeadersBlock) header{

    [self addParams:nil andHeaders:header];
}
@end
