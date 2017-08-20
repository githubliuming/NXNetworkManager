//
//  NXNetworkBlock.h
//  NXNetworkManager
//
//  Created by 明刘 on 2017/8/13.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#ifndef NXNetworkBlock_h
#define NXNetworkBlock_h

@class NXRequset;
@protocol AFMultipartFormData;
@protocol NXParamContainerProtol;
@protocol NXHttpHeaderContainerProtol;



typedef void(^NXCompletionHandlerBlock)(NSURLResponse *responese,id responseObject,NSError * error, NXRequset * requset);

typedef void(^NXSuccesBlock)(NSURLSessionDataTask * task,id responseObject, NXRequset * requset);

typedef void (^NXFailureBlock)(NSURLSessionDataTask * task, NSError *error,NXRequset * requset);

typedef void (^NXFormDataBlock)(id<AFMultipartFormData>  formData);

typedef void (^NXProgressBlock)(double progress);

typedef void(^ NXParamsBlock)(id<NXParamContainerProtol> params);
typedef void(^ NXHeadersBlock)(id<NXHttpHeaderContainerProtol> headers);

#endif /* NXNetworkBlock_h */
