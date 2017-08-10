//
//  NXRequestHeader.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXRequestHeader.h"

@implementation NXRequestHeader

#pragma mark- NXNetWorkHttpHeaderContainerProtol
- (NSDictionary *) headerInfoConfigDic
{
    return [[NSDictionary alloc] initWithDictionary:self.containerConfigDic];
}
@end
