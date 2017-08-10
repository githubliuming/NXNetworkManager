//
//  NXParamContainer.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXParamContainer.h"

@interface NXParamContainer ()

@end
@implementation NXParamContainer


#pragma mark NXNetWorkParamContainerProtol
- (NSDictionary *)params{

    return [[NSDictionary alloc] initWithDictionary:self.containerConfigDic];
}
@end
