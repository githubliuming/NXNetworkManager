//
//  NXHttpsCerConfig.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/9/4.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXHttpsCerConfig.h"
#import "AFSecurityPolicy.h"

@interface NXHttpsCerConfig (){

    AFSecurityPolicy * _securityPolicy;
}

@end
@implementation NXHttpsCerConfig
+ (instancetype) shareInstanced{

    static NXHttpsCerConfig * nx_https_cer_config = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nx_https_cer_config = [[NXHttpsCerConfig alloc] init];
    });
    return nx_https_cer_config;
}

- (AFSecurityPolicy *)securityPolicy{

    if (self.cerPath.length > 0) {
      
        if ([[NSFileManager defaultManager] fileExistsAtPath:self.cerPath]) {
            
            NSData *cerData = [NSData dataWithContentsOfFile:self.cerPath];
            _securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
            //设置是否允许不信任的证书（证书无效、证书时间过期）通过验证 ，默认为NO.
            _securityPolicy.allowInvalidCertificates = YES;
            //是否验证域名证书的CN(common name)字段。默认值为YES。
            _securityPolicy.validatesDomainName = NO;
            //根据验证模式来返回用于验证服务器的证书
            _securityPolicy.pinnedCertificates = [NSSet setWithObject:cerData];
            
        } else {
        
            NSLog(@"路径文件不存在");
        }
        
    }
    
    return _securityPolicy;
}

@end
