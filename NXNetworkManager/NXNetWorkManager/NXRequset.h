//
//  NXRequset.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXNetWorkProtol.h"
/**
 Http requset
 */
@interface NXRequset : NSObject

- (instancetype) initWithUrl:(NSString * )url;

@property(nonatomic,strong)NSString * url;


/**
 上传 或者 下载文件存放的路径
 */
@property(nonatomic,strong) NSString * fileUrl;
/**
 http 请求参数信息
 */
@property(nonatomic,strong)id<NXParamContainerProtol> params;

/**
 http 请求头信息
 */
@property(nonatomic,strong)id<NXHttpHeaderContainerProtol> headers;


@end
