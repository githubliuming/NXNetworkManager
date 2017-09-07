//
//  NXHeaderAndParamsConfig.h
//  NXNetworkManager
//
//  Created by 明刘 on 2017/8/13.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXNetWorkProtol.h"

@interface NXHeaderAndParamsConfig : NSObject

+ (instancetype) shareInstanceted;

@property(nonatomic,copy)NSString * httpCerName;

- (void)addParams:(NXAddHeaderOrParamsBlock) paramContainer;

- (void)addHeader:(NXAddHeaderOrParamsBlock)headerContainer;

-(NSDictionary *) params;
- (NSDictionary *)headerInfoConfigDic;
@end
