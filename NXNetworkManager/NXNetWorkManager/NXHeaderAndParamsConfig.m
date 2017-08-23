//
//  NXHeaderAndParamsConfig.m
//  NXNetworkManager
//
//  Created by 明刘 on 2017/8/13.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXHeaderAndParamsConfig.h"
#import "NXContainer.h"
@interface NXHeaderAndParamsConfig ()
@property(strong,nonatomic)  NXContainer * httpHeaders;
@property(strong,nonatomic) NXContainer * httpParams;
@end
@implementation NXHeaderAndParamsConfig

+ (instancetype) shareInstanceted{

   static NXHeaderAndParamsConfig * config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        config = [[NXHeaderAndParamsConfig alloc] init];
    });
    
    return config;
}

- (NXContainer *) httpHeaders{
    if (_httpHeaders == nil) {
        
        _httpHeaders = [[NXContainer alloc] init];
    }
    
    return _httpHeaders;
}

- (NXContainer *) httpParams{

    if (_httpParams == nil) {
        
        _httpParams = [[NXContainer alloc] init];
    }
    
    return _httpParams;
}

- (void)addParams:(NXAddHeaderOrParamsBlock) paramContainer{

    if (paramContainer) {
        
        paramContainer(self.httpParams);
    }
}

- (void)addHeader:(NXAddHeaderOrParamsBlock)headerContainer{

    if (headerContainer) {
        
        headerContainer(self.httpHeaders);
    }
}

-(NSDictionary *) params{

    return [[NSDictionary alloc] initWithDictionary:self.httpParams.containerConfigDic];
}

- (NSDictionary *)headerInfoConfigDic{

    return [[NSDictionary alloc] initWithDictionary:self.httpHeaders.containerConfigDic];
}


@end
