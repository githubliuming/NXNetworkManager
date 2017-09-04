//
//  NXHttpsCerConfig.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/9/4.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXHttpsCerConfig : NSObject

- (instancetype) shareInstanced;

@property(nonatomic,copy)NSString * cerPath;
- (id)cerData;
@end
