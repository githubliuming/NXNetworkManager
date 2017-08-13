//
//  NXRequset.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXRequset.h"
#import "NXHeaderAndParamsConfig.h"
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
        
        NSDictionary * defaultDic  = [NXHeaderAndParamsConfig shareInstanceted].headerInfoConfigDic;
        [defaultDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            [_headers addString:obj forKey:key];
        }];
    }

    return _headers;
}

- (id<NXParamContainerProtol>)params{

    if (!self.ingoreDefaultHttpParams) {
        
        NSDictionary * defaultDic = [[NXHeaderAndParamsConfig shareInstanceted] params];
        [defaultDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
           
            [_params addString:obj forKey:key];
        }];
    }
    
    return _params;
}
@end
