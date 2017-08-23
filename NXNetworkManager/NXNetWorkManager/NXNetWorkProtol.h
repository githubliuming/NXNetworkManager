//
//  NXNetWorkProtol.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXNetworkBlock.h"

/**
 NXNetWorkManager 内部协议
 */
@protocol NXNetWorkProtol <NSObject>

@end

@protocol NXContainerProtol <NSObject>

- (NSDictionary *) containerConfigDic;

- (NXContainerAddIntegerBlock)addInteger;
- (NXContainerAddDoubleBlock)addDouble;
- (NXContainerAddStringgerBlock)addString;

@end

@protocol NXParamContainerProtol <NSObject>

- (NSDictionary *) params;

@end

@protocol NXHttpHeaderContainerProtol <NSObject>

- (NSDictionary *) headerInfoConfigDic;

@end

