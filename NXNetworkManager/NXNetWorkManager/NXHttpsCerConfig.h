//
//  NXHttpsCerConfig.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/9/4.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFSecurityPolicy;
@interface NXHttpsCerConfig : NSObject

+ (instancetype) shareInstanced;

@property(nonatomic,copy)NSString * cerPath;

@property(nonatomic,strong,readonly)AFSecurityPolicy * securityPolicy;
@end
