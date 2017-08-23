//
//  NXContainer.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXContainer.h"

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
