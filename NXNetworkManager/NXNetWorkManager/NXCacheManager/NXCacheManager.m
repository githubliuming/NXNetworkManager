//
//  NXCacheManager.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/15.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXCacheManager.h"

@interface NXCacheManager ()
@property(nonatomic,strong) NSOperationQueue * writeQueue;  //写入缓存队列
@property(nonatomic,strong) NSOperationQueue * readQueue;  //读取队列
@end

@implementation NXCacheManager

- (instancetype) shareIndstanced{

    static NXCacheManager * nx_cache_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        nx_cache_manager = [[NXCacheManager alloc] init];
    });
    
    return nx_cache_manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.writeQueue = [[NSOperationQueue alloc] init];
        self.writeQueue.maxConcurrentOperationCount  = 5.0f;
        
        self.readQueue = [[NSOperationQueue alloc] init];
        self.readQueue.maxConcurrentOperationCount  = 5.0f;
        
        self.cachePath = [self defalutCachePath];
    }
    return self;
}

- (NSString *)defalutCachePath{
    
    NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
    basePath = [basePath stringByAppendingPathComponent:@"NXNetworkingCache"];
    return basePath;
}

#pragma mark run at queue
- (void)runWriteQueu:(void(^)()) block{

    [self.writeQueue addOperationWithBlock:block];
}
- (void)runReadqueue:(void(^)())block{

    [self.readQueue addOperationWithBlock:block];
}
@end
