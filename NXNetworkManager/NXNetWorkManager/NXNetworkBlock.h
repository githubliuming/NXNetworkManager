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
@protocol NXContainerProtol;

typedef void(^NXCompletionHandlerBlock)(NSURLResponse *responese,id responseObject,NSError * error, NXRequset * requset);

typedef void(^NXSuccesBlock)(NSURLSessionDataTask * task,id responseObject, NXRequset * requset);

typedef void (^NXFailureBlock)(NSURLSessionDataTask * task, NSError *error,NXRequset * requset);

typedef void (^NXFormDataBlock)(id<AFMultipartFormData>  formData);

typedef void (^NXProgressBlock)(double progress);

typedef  id<NXContainerProtol>(^NXContainerAddIntegerBlock)(NSInteger value,NSString * key);
typedef  id<NXContainerProtol>(^NXContainerAddDoubleBlock)(double value,NSString * key);
typedef  id<NXContainerProtol>(^NXContainerAddStringgerBlock)(NSString * value,NSString * key);

typedef void (^NXAddHeaderOrParamsBlock)(id<NXContainerProtol> container);
#endif /* NXNetworkBlock_h */
