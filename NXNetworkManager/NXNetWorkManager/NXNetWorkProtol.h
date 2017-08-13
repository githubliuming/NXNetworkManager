//
//  NXNetWorkProtol.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 NXNetWorkManager 内部协议
 */
@protocol NXNetWorkProtol <NSObject>

@end

@protocol NXContainerProtol <NSObject>

- (void) addInteger:(NSInteger) i forKey:(NSString *)key;
- (void) addDouble:(double)     d forKey:(NSString *)key;
- (void) addString:(NSString *) s forKey:(NSString *)key;

- (NSDictionary *) containerConfigDic;

@end

@protocol NXParamContainerProtol <NXContainerProtol>

- (NSDictionary *) params;

@end

@protocol NXHttpHeaderContainerProtol <NXContainerProtol>

- (NSDictionary *) headerInfoConfigDic;

@end

