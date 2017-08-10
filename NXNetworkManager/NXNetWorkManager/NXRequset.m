//
//  NXRequset.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXRequset.h"

@implementation NXRequset

- (instancetype) initWithUrl:(NSString * )url{

    self = [super init];
    if (self) {
        
        self.url = url;
    }
    return self;
    
}
- (instancetype)init
{
    return [self initWithUrl:@""];
}
@end
