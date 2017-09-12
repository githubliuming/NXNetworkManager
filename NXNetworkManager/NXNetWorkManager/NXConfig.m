//
//  NXConfig.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/9/7.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXConfig.h"
@interface NXConfig()
@property(nonatomic,strong)NXContainer * globalParamsContainer;
@property(nonatomic,strong)NXContainer * globalHeadersContainer;
@end

@implementation NXConfig

- (instancetype)shareInstanced
{
    static NXConfig *nx_config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nx_config = [[NXConfig alloc] init];
    });
    
    return nx_config;
}

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

@interface NXContainer ()

@property(nonatomic,strong)NSMutableDictionary * containerDic;
@end

@implementation NXContainer


- (NSMutableDictionary *)containerDic{
    
    if (_containerDic == nil) {
        
        _containerDic = [[NSMutableDictionary alloc] init];
    }
    return _containerDic;
}
#pragma mark - NXContainerProtol

- (NSDictionary *)containerConfigDic{
    
    return [[NSDictionary alloc] initWithDictionary:self.containerDic];
}

- (NXContainerAddIntegerBlock)addInteger{
    
    return ^(NSInteger value,NSString * key){
        
        NSString * value_ = [NSString stringWithFormat:@"%ld",(long)value];
        
        return self.addString(value_,key);
    };
}
- (NXContainerAddDoubleBlock)addDouble{
    
    return ^(double value,NSString * key){
        
        NSString * value_ = [NSString stringWithFormat:@"%f",value];
        return self.addString(value_,key);
    };
}
- (NXContainerAddStringgerBlock)addString{
    
    return ^(NSString * value,NSString * key){
        
        NSAssert(key, @" param key can not nil");
        
        if (value.length <= 0) {
            value = @"";
        }
        [self.containerDic setObject:value forKey:key];
        return self;
    };
}
@end
