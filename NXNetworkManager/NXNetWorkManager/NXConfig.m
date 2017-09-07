//
//  NXConfig.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/9/7.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXConfig.h"
#import "NXContainer.h"
@interface NXConfig()
@property(nonatomic,strong)NXContainer * globalParamsContainer;
@property(nonatomic,strong)NXContainer * globalHeadersContainer;
@end

@implementation NXConfig

- (instancetype) init{

    self = [super init];
    if (self) {
     
        self.globalParamsContainer = [[NXContainer alloc] init];
        self.globalHeadersContainer = [[NXContainer alloc] init];
    }
    return self;
}
- (void)addParams:(NXAddHeaderOrParamsBlock)params
{
    if (params) {
        
        params(_globalParamsContainer);
    }
}
- (void)addHeaders:(NXAddHeaderOrParamsBlock)headers
{
    if (headers) {
        
        headers(_globalHeadersContainer);
    }
}
- (NSDictionary *)globalParams{

    return self.globalParamsContainer.containerConfigDic;
}
- (NSDictionary *)globalHeaders{

    return self.globalHeadersContainer.containerConfigDic;
}
@end
