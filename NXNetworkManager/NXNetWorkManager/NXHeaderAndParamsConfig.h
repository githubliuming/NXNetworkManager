//
//  NXHeaderAndParamsConfig.h
//  NXNetworkManager
//
//  Created by 明刘 on 2017/8/13.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXNetWorkProtol.h"

@interface NXHeaderAndParamsConfig : NSObject<NXParamContainerProtol,NXHttpHeaderContainerProtol>


+ (instancetype) shareInstanceted;

- (void) addValue:(NSString *) value forHttpParam:(NSString *) key;

- (void) addHeader:(NSString *) value forHttpHeader:(NSString *) key;


@end
