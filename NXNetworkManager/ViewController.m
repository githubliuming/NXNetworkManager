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

@property(nonatomic,strong)NXDownLoadManager * download;

@property(nonatomic,strong) NSString * taskId;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.download = [NXDownLoadManager shareInstanced];
    self.progressUI.progress = 0.0f;
    
    double time = [[NSDate date] timeIntervalSince1970];
    
    NXRequset * request = [[NXRequset alloc] initWithUrl:@"http://data.philm.cc/sticker/2017/v18/check_version.json"];
<<<<<<< HEAD
    
    [request addParams:^(id<NXContainerProtol> container) {
        
        container.addDouble(time,@"time");
        
=======
    [request addParams:^(id<NXParamContainerProtol> params) {
       
>>>>>>> f843e34dd221fddfe4e5c9e7b9d6cc87836dfce0
    }];
    
    [[NXNetWorkSession shareInstanced] Get:request success:^(NSURLSessionDataTask *task, id responseObject, NXRequset *requset) {
        
        NSLog(@"responseObject = %@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error, NXRequset *requset) {
        
        NSLog(@"error = %@",[error userInfo]);
    }];
    
}

- (IBAction)startDownLoader:(id)sender {
    
    NXRequset * request = [[NXRequset alloc] initWithUrl:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg"];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"QQ_V5.4.0.dmg"];
    request.fileUrl = path;
    
    
    __weak typeof(self) weakSelf = self;
  self.taskId = [self.download downLoad:request progress:^(double progress) {
       
        weakSelf.progressUI.progress = progress;
    } completionHandler:^(NSURLResponse *responese, id responseObject, NSError *error, NXRequset *requset) {
        
        if (!error) {
         
             NSLog(@"下载完成");
            
        } else {
        
            NSLog(@"error == %@",[error userInfo]);
        }
    }];
    
    NSLog(@"taskId === %@",self.taskId);
}


- (IBAction)pauseDownLoad:(id)sender {
    
    [self.download suspendWithTaskid:self.taskId];
}

- (IBAction)continueDownLoad:(id)sender
{
    
    [self.download resumeWithTaskId:self.taskId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
