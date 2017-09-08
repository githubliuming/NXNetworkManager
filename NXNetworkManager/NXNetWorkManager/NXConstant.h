//
//  NXConstant.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/9/8.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#ifndef NXConstant_h
#define NXConstant_h

@class NXRequset;
@protocol AFMultipartFormData;
@protocol NXContainerProtol;

#pragma mark - block声明模块
typedef void(^NXCompletionHandlerBlock)(NSURLResponse *responese,id responseObject,NSError * error, NXRequset * requset);

typedef void(^NXSuccesBlock)(NSURLSessionDataTask * task,id responseObject, NXRequset * requset);

typedef void (^NXFailureBlock)(NSURLSessionDataTask * task, NSError *error,NXRequset * requset);

typedef void (^NXFormDataBlock)(id<AFMultipartFormData>  formData);

typedef void (^NXProgressBlock)(double progress);

typedef  id<NXContainerProtol>(^NXContainerAddIntegerBlock)(NSInteger value,NSString * key);
typedef  id<NXContainerProtol>(^NXContainerAddDoubleBlock)(double value,NSString * key);
typedef  id<NXContainerProtol>(^NXContainerAddStringgerBlock)(NSString * value,NSString * key);

typedef void (^NXAddHeaderOrParamsBlock)(id<NXContainerProtol> container);


#pragma mark - 协议声明模块
/**
 NXNetWorkManager 内部协议
 */
@protocol NXContainerProtol <NSObject>

- (NSDictionary *) containerConfigDic;

- (NXContainerAddIntegerBlock)addInteger;
- (NXContainerAddDoubleBlock)addDouble;
- (NXContainerAddStringgerBlock)addString;

@end

#pragma mark 枚举声明模块
typedef NS_ENUM(NSInteger,NXRequestType) {

    NXRequestTypeNormal,   /// get post put delete...
    NXRequestTypeUpload,   /// 上传文件
    kXMRequestDownload,    /// 下载文件
};

typedef NS_ENUM(NSInteger,NXHTTPMethodType) {

    NXHTTPMethodTypeOfGET,  //get请求
    NXHTTPMethodTypeOfPOST, //post请求
    NXHTTPMethodTypeOfHEAD, //head
    NXHTTPMethodTypeOfDELETE,//delete
    NXHTTPMethodTypeOfPUT,   //put
    NXHTTPMethodTypeOfPATCH, //批量 (暂时不处理)
};
#endif /* NXConstant_h */
