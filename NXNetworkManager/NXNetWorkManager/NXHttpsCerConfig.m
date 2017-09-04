//
//  NXHttpsCerConfig.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/9/4.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXHttpsCerConfig.h"

@implementation NXHttpsCerConfig
- (instancetype) shareInstanced{

    static NXHttpsCerConfig * nx_https_cer_config = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nx_https_cer_config = [[NXHttpsCerConfig alloc] init];
    });
    return nx_https_cer_config;
}

- (id)cerData{

    NSSet * cerSet = nil;
    if (self.cerPath.length > 0) {
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:self.cerPath])
        {
            NSData * certData =[NSData dataWithContentsOfFile:self.cerPath];
            cerSet = [[NSSet alloc] initWithObjects:certData, nil];
            
        } else {
        
            NSLog(@"证书文件不存在");
        }
    }
    
    return cerSet;
}
@end
