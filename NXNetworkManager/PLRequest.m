//
//  PLRequest.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/9/7.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "PLRequest.h"
#import "NXConfig.h"
@implementation PLRequest

-(instancetype) initWithUrl:(NSString *)url{

    self = [super initWithUrl:url];
    if (self) {
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            [NXConfig shareInstanced].baseUrl = @"http://data.philm.cc/sticker/2017/v18/";
            [NXConfig shareInstanced].globalParams.addString(@"1234",@"param1");
            [NXConfig shareInstanced].globalParams.addString(@"1234",@"param2");
            [NXConfig shareInstanced].globalParams.addString(@"1234",@"param4");
            [NXConfig shareInstanced].globalParams.addString(@"1234",@"param3");
            
            [NXConfig shareInstanced].globalHeaders.addString(@"1234",@"header1");
            [NXConfig shareInstanced].globalHeaders.addString(@"1234",@"header2");
            [NXConfig shareInstanced].globalHeaders.addString(@"1234",@"header3");
            [NXConfig shareInstanced].globalHeaders.addString(@"1234",@"header4");
            
            [NXConfig shareInstanced].consoleLog = YES;
        });
        
    }
    
    return self;
}
@end
