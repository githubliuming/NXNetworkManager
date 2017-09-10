//
//  NXBridge.h
//  NXNetworkManager
//
//  Created by 明刘 on 2017/9/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NXRequset;
@interface NXBridge : NSObject

+ (instancetype)NXBrige;
+ (instancetype) shareInstaced;

- (void)cancleRequst:(NSString *)identifier;
- (NXRequset *)getRequestByIdentifier:(NSString *)identifier;

-(void)sendWithRequst:(NXRequset *)requset;
@end
