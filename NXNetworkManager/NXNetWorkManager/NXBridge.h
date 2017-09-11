//
//  NXBridge.h
//  NXNetworkManager
//
//  Created by 明刘 on 2017/9/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NXCompleteBlcok)(id responseObject, NSError *error);

@class NXRequest;
@interface NXBridge : NSObject

+ (instancetype)NXBrige;
+ (instancetype) shareInstaced;

- (void)cancleRequst:(NSString *)identifier;
- (NXRequest *)getRequestByIdentifier:(NSString *)identifier;

-(void)sendWithRequst:(NXRequest *)requset completionHandler:(NXCompleteBlcok)completionHandler;
@end
