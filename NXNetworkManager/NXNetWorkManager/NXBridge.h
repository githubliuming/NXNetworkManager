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

+ (instancetype)brige;
+ (instancetype) shareInstaced;

-(void)sendWithRequst:(NXRequest *)request completionHandler:(NXCompleteBlcok)completionHandler;

- (NXRequest *)cancleRequst:(NSString *)identifier;
- (NXRequest *)getRequestByIdentifier:(NSString *)identifier;
@end
