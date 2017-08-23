//
//  NXDownLoadManager.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXDownLoadManager.h"

@interface NXDownLoadManager ()

@property(nonatomic,strong)NSOperationQueue * downloadQueue;
@property(nonatomic,strong)NSMutableDictionary <NSString * ,NXDownLoad *>* downMapDic;

@end
@implementation NXDownLoadManager

+ (instancetype) shareInstanced{

    static NXDownLoadManager * downloadMananger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        downloadMananger = [[NXDownLoadManager alloc] init];
    });
    
    return downloadMananger;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.maxDownloadCount = 5.0f;
    }
    return self;
}

-(NSMutableDictionary *) downMapDic{

    if (_downMapDic == nil){
    
        _downMapDic = [[NSMutableDictionary alloc] init];
    }
    
    return _downMapDic;
}
- (NSOperationQueue *)downloadQueue{

    if (_downloadQueue == nil) {
        
        _downloadQueue = [[NSOperationQueue alloc] init];
        
    }
     return _downloadQueue ;
}

- (void) setMaxDownloadCount:(NSInteger)maxDownloadCount{

    _maxDownloadCount = maxDownloadCount;
    self.downloadQueue.maxConcurrentOperationCount = _maxDownloadCount;
}

- (NSString *)downLoad:(NXRequset *) requset
              progress:(NXProgressBlock) progress
     completionHandler:(NXCompletionHandlerBlock) completionBlock{

    NSString * url = requset.url;
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    NSString * taskId  = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NXDownLoad * downLoad =  [self.downMapDic objectForKey:taskId];
    
    if (!downLoad) {
     
        downLoad = [[NXDownLoad alloc] init];
        
        [self.downMapDic setObject:downLoad forKey:taskId];
        [self.downloadQueue addOperationWithBlock:^{
            
            [downLoad downLoad:requset progress:progress completionHandler:^(NSURLResponse *responese, id responseObject, NSError *error, NXRequset *requset) {
                
                if (completionBlock) {
                 
                    completionBlock(responese,responseObject,error,requset);
                }
                [self.downMapDic removeObjectForKey:taskId];
            }];
        }];
    } else {
    
        [downLoad resume];
    }
    return taskId;
}
- (void)cancelAllTask{

    @synchronized (self.downMapDic) {
       
        NSArray * allTaskIds = [self.downMapDic allKeys];
        for (NSString * taskId in allTaskIds) {
            
            NXDownLoad * download = self.downMapDic[taskId];
            if (download)
            {
                [download cancel];
                [self.downMapDic removeObjectForKey:taskId];
            }
        }
        [self.downloadQueue cancelAllOperations];
        
    }

}
- (void)cancelTaskWithTaskId:(NSString *)taskId{

    NSAssert(taskId !=nil, @"taskid is nil");
    
    @synchronized (self.downMapDic) {
        
        NXDownLoad * download = self.downMapDic[taskId];
        if (download)
        {
            [download cancel];
            [self.downMapDic removeObjectForKey:taskId];
        }
    }
}
- (void)resumeAllTask{

    @synchronized (self.downMapDic) {
     
        NSArray * allTaskIds = [self.downMapDic allKeys];
        for (NSString * taskId in allTaskIds) {
            
            NXDownLoad * download = self.downMapDic[taskId];
            if (download)
            {
                [download resume];
            }
        }
        
    }
}

- (void)resumeWithTaskId:(NSString *)taskId{

    NSAssert(taskId !=nil, @"taskid is nil");
    @synchronized (self.downMapDic) {
        
        NXDownLoad * download = self.downMapDic[taskId];
        if (download)
        {
            [download resume];
        }
    }
}

- (void)suspendAllTask{

    @synchronized (self.downMapDic) {
     
        NSArray * allTaskIds = [self.downMapDic allKeys];
        for (NSString * taskId in allTaskIds) {
            
            NXDownLoad * download = self.downMapDic[taskId];
            if (download) {
                
                [download suspend];
            }
        }
        
    }
}

- (void)suspendWithTaskid:(NSString *)taskId{

    NSAssert(taskId !=nil, @"taskid is nil");
    
    @synchronized (self.downMapDic) {
        
        NXDownLoad * download = self.downMapDic[taskId];
        if (download) {
            
            [download suspend];
        }
        
    }
}
@end
