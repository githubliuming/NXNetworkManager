//
//  ViewController.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/8/10.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "ViewController.h"

#import "NXNetWorkManagerHeader.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressUI;

//@property(nonatomic,strong)NXDownLoadManager * download;

@property(nonatomic,strong) NSString * taskId;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.download = [NXDownLoadManager shareInstanced];
    self.progressUI.progress = 0.0f;
    
    double time = [[NSDate date] timeIntervalSince1970];
    
//    NXRequest * request = [[NXRequest alloc] initWithUrl:@"http://data.philm.cc/sticker/2017/v18/check_version.json"];
    
//    [request addParams:^(id<NXContainerProtol> container) {
//        
//        container.addDouble(time,@"time").addString(@"kkk",@"jjj");
//        
//    }];
//    
//    [[NXNetWorkSession shareInstanced] Get:request success:^(NSURLSessionDataTask *task, id responseObject, NXRequest *requset) {
//        
//        NSLog(@"responseObject = %@",responseObject);
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error, NXRequest *requset) {
//        
//        NSLog(@"error = %@",[error userInfo]);
//    }];
    
    NXRequest * request = [[NXRequest alloc] initWithUrl:@"http://data.philm.cc/sticker/2017/v18/check_version.json"];
    request.ingoreBaseUrl = YES;
    request.requstType = NXRequestTypeNormal;
    request.requstSerializer = NXHTTPRrequstSerializerTypeJSON;
    request.resopseSerializer = NXHTTResposeSerializerTypeJSON;
    [request addParams:^(id<NXContainerProtol> container) {
       
        container.addDouble(time,@"time");
    }];
    
    [request startWith:^(id responseObject, NXRequest *requset) {
        
        NSLog(@"responseObject = %@",responseObject);
    } failure:^(NSError *error, NXRequest *requset) {
        
        NSLog(@"error = %@",[error userInfo]);
    }];
    
}

- (IBAction)startDownLoader:(id)sender {
    
    NXRequest * request = [[NXRequest alloc] initWithUrl:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg"];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"QQ_V5.4.0.dmg"];
    request.fileUrl = path;
    request.requstType = kXMRequestDownload;
    
    __weak typeof(self) weakSelf = self;
    
    [request startWith:^(double progress) {
        
        NSLog(@"----> proogress = %f",progress);
        weakSelf.progressUI.progress = progress;
    } success:^(id responseObject, NXRequest *requset) {
        
        NSLog(@"下载成功");
    } failure:^(NSError *error, NXRequest *requset) {
        
        NSLog(@"error = %@",error);
    }];
}


- (IBAction)pauseDownLoad:(id)sender {
    
//    [self.download suspendWithTaskid:self.taskId];
}

- (IBAction)continueDownLoad:(id)sender
{
    
//    [self.download resumeWithTaskId:self.taskId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
