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
- (void)addInteger:(NSInteger) i forKey:(NSString *)key{
    
    NSString * value = [NSString stringWithFormat:@"%ld",(long)i];
    [self addString:value forKey:key];
}
- (void)addDouble:(double)     d forKey:(NSString *)key{
    
    NSString * value = [NSString stringWithFormat:@"%f",d];
    [self addString:value forKey:key];
}
- (void)addString:(NSString *) s forKey:(NSString *)key{
    
    NSAssert(key, @" param key can not nil");
    if (s.length <= 0) {
        s = @"";
    }
    [self.containerDic setObject:s forKey:key];
}

#pragma mark - NXContainerProtol

- (NSDictionary *)containerConfigDic{
    
    return [[NSDictionary alloc] initWithDictionary:self.containerDic];
}
@end
