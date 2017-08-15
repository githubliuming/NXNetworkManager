//
//  NXCacheManager.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/15.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXCacheManager : NSObject

- (instancetype) shareIndstanced;

@property(nonatomic,copy) NSString * cachePath;
@property(nonatomic,assign)NSInteger writeQueueNum;  //写入线程queue最大并发数 默认 5
@property(nonatomic,assign)NSInteger readQueueNum;   //读取线程queue最大并发数 默认 5

- (void)setObj:(id<NSCopying>) obj forKey:(NSString *)key;
- (id)objForKey:(NSString *) key;
@end
