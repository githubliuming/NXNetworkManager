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
<<<<<<< HEAD
@protocol NXContainerProtol;
=======
@protocol NXParamContainerProtol;
@protocol NXHttpHeaderContainerProtol;


>>>>>>> f843e34dd221fddfe4e5c9e7b9d6cc87836dfce0

typedef void(^NXCompletionHandlerBlock)(NSURLResponse *responese,id responseObject,NSError * error, NXRequset * requset);

typedef void(^NXSuccesBlock)(NSURLSessionDataTask * task,id responseObject, NXRequset * requset);

typedef void (^NXFailureBlock)(NSURLSessionDataTask * task, NSError *error,NXRequset * requset);

typedef void (^NXFormDataBlock)(id<AFMultipartFormData>  formData);

typedef void (^NXProgressBlock)(double progress);

<<<<<<< HEAD
typedef  id<NXContainerProtol>(^NXContainerAddIntegerBlock)(NSInteger value,NSString * key);
typedef  id<NXContainerProtol>(^NXContainerAddDoubleBlock)(double value,NSString * key);
typedef  id<NXContainerProtol>(^NXContainerAddStringgerBlock)(NSString * value,NSString * key);

typedef void (^NXAddHeaderOrParamsBlock)(id<NXContainerProtol> container);
=======
typedef void(^ NXParamsBlock)(id<NXParamContainerProtol> params);
typedef void(^ NXHeadersBlock)(id<NXHttpHeaderContainerProtol> headers);

>>>>>>> f843e34dd221fddfe4e5c9e7b9d6cc87836dfce0
#endif /* NXNetworkBlock_h */
