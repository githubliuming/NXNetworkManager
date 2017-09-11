//
//  NXDownLoad.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXDownLoad.h"
#import "AFNetworking.h"
#import "NXRequest.h"
@interface NXDownLoad ()


/** AFNetworking断点下载（支持离线）需用到的属性 **********/
/** 文件的总长度 */
@property (nonatomic, assign) NSInteger fileLength;
/** 当前下载长度 */
@property (nonatomic, assign) NSInteger currentLength;
/** 文件句柄对象 */
@property (nonatomic, strong) NSFileHandle *fileHandle;


@property (nonatomic, strong) AFURLSessionManager *manager;
@property (nonatomic, strong) NSURLSessionDataTask *downloadTask;

@property(nonatomic,strong) NSString * fileUrl;

@property(nonatomic,strong) NXRequest * request;

@end
@implementation NXDownLoad

/**
 * manager的懒加载
 */
- (AFURLSessionManager *)AFSessionManager{
    if (!_manager) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        // 1. 创建会话管理者
        _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        _manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    }
    return _manager;
}

- (void)downLoad:(NXRequest *) requset
                 progress:(NXProgressBlock) progress
        completionHandler:(NXCompletionHandlerBlock) completionBlock{

    self.request = requset;
    
    self.fileUrl = requset.fileUrl;
    NSMutableURLRequest *downRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requset.url]];
    // 设置HTTP请求头中的Range
    self.currentLength = [self fileLengthForPath:self.fileUrl];
    NSString *range = [NSString stringWithFormat:@"bytes=%ld-", (long)self.currentLength];
    [downRequest setValue:range forHTTPHeaderField:@"Range"];
    [downRequest setValue:@"application/octet-stream" forHTTPHeaderField:@"content-type"];
    
    __weak typeof(self) weakSelf = self;
    AFURLSessionManager * manager = [self AFSessionManager];
    
   _downloadTask = [manager dataTaskWithRequest:downRequest uploadProgress:nil downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
       dispatch_async(dispatch_get_main_queue(), ^{
           
           if (progress) {
            
               //weakSelf.currentLength +
               double downProgress_ = (weakSelf.currentLength + downloadProgress.completedUnitCount * 1.0f)/weakSelf.fileLength;
               progress(downProgress_);
           }
       });
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        // 清空长度
        weakSelf.currentLength = 0;
        weakSelf.fileLength = 0;
        // 关闭fileHandle
        [weakSelf.fileHandle closeFile];
        weakSelf.fileHandle = nil;
        if (completionBlock) {
            
            completionBlock(response,responseObject,error,requset);
        }
    }];
    
    [self.manager setDataTaskDidReceiveResponseBlock:^NSURLSessionResponseDisposition(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSURLResponse * _Nonnull response) {
        NSLog(@"NSURLSessionResponseDisposition");
        
        // 获得下载文件的总长度：请求下载的文件长度 + 当前已经下载的文件长度
        weakSelf.fileLength = response.expectedContentLength + self.currentLength;
        
        // 沙盒文件路径
        NSString *path = weakSelf.fileUrl;
        
        NSLog(@"File downloaded to: %@  fileLength = %ld",path,(long)weakSelf.fileLength);
        
        // 创建一个空的文件到沙盒中
        NSFileManager *manager = [NSFileManager defaultManager];
        
        if (![manager fileExistsAtPath:path]) {
            // 如果没有下载文件的话，就创建一个文件。如果有下载文件的话，则不用重新创建(不然会覆盖掉之前的文件)
            [manager createFileAtPath:path contents:nil attributes:nil];
        }
        
        // 创建文件句柄
        weakSelf.fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
        
        // 允许处理服务器的响应，才会继续接收服务器返回的数据
        return NSURLSessionResponseAllow;
    }];
    
    [self.manager setDataTaskDidReceiveDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSData * _Nonnull data) {
        
        // 指定数据的写入位置 -- 文件内容的最后面
        [weakSelf.fileHandle seekToEndOfFile];
        
        // 向沙盒写入数据
        [weakSelf.fileHandle writeData:data];
        
    }];

    [self.downloadTask resume];
}

/**
 * 获取已下载的文件大小
 */
- (NSInteger)fileLengthForPath:(NSString *)path {
    NSInteger fileLength = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileLength = [fileDict fileSize];
        }
    }
    return fileLength;
}

- (void)cancel{

    if (self.downloadTask) {
        
        [self.downloadTask cancel];
    }
}

- (void)suspend{

    if (self.downloadTask.state == NSURLSessionTaskStateRunning)
    {
        [self.downloadTask suspend];
    }
}
- (void)resume{

    if (self.downloadTask.state == NSURLSessionTaskStateSuspended)
    {
        [self.downloadTask resume];
    }
}

@end
