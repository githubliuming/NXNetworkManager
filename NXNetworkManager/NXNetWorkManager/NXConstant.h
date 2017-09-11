//
//  NXConstant.h
//  NXNetworkManager
//
//  Created by yoyo on 2017/9/8.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#ifndef NXConstant_h
#define NXConstant_h

@class NXRequest;
@protocol AFMultipartFormData;
@protocol NXContainerProtol;

#pragma mark - block声明模块
typedef void(^NXCompletionHandlerBlock)(NSURLResponse *responese,id responseObject,NSError * error, NXRequest * requset);

typedef void(^NXSuccesBlock)(NSURLSessionDataTask * task,id responseObject, NXRequest * requset);

typedef void (^NXFailureBlock)(NSURLSessionDataTask * task, NSError *error,NXRequest * requset);

typedef void (^NXFormDataBlock)(id<AFMultipartFormData>  formData);

typedef void (^NXProgressBlock)(double progress);
typedef void (^NXCompletionBlock)(NSURLSessionDataTask * task ,NXRequest * requset,NSError * error);

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

/**
 请求httpBody Content-Type的内容

 - NXHTTPRrequstSerializerTypeRAW:  设置Content-Type为   application/x-www-form-urlencoded
 - NXHTTPRrequstSerializerTypeJSON: 设置Content-Type为   application/json
 - NXHTTPRrequstSerializerTypePlist:设置Content-Type为   application/json
 */
typedef NS_ENUM(NSInteger,NXRequstSerializerType)
{
    NXHTTPRrequstSerializerTypeRAW,     ///<* application/x-www-form-urlencoded
    NXHTTPRrequstSerializerTypeJSON,   ///<* application/json
    NXHTTPRrequstSerializerTypePlist,  ///<* application/x-plist
};

/**
 响应体序列化类型

 - NXHTTResposeSerializerTypeRAW:
 - NXHTTResposeSerializerTypeJSON: 序列化成json
 - NXHTTResposeSerializerTypePlist: 序列化成plist
 - NXHTTResposeSerializerTypeXML: 序列化xml
 */
typedef NS_ENUM(NSInteger,NXResposeSerializerType) {

    NXHTTResposeSerializerTypeRAW, ///<*
    NXHTTResposeSerializerTypeJSON, ///<* json
    NXHTTResposeSerializerTypePlist, ///<* plist
    NXHTTResposeSerializerTypeXML,///<* xml
};

#endif /* NXConstant_h */
