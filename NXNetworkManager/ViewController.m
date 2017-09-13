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
@property(nonatomic,strong)NXRequest * request;

@property(nonatomic,strong) NSString * taskId;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.progressUI.progress = 0.0f;
    
    double time = [[NSDate date] timeIntervalSince1970];
    NXRequest * request = [[NXRequest alloc] initWithUrl:@"http://data.philm.cc/sticker/2017/v18/check_version.json"];
    request.ingoreBaseUrl = YES;
    request.requstType = NXRequestTypeNormal;
    request.requstSerializer = NXHTTPRrequstSerializerTypeJSON;
    request.resopseSerializer = NXHTTResposeSerializerTypeJSON;
    
    request.params.addDouble(time,@"time");
    
    [request startWith:^(id responseObject, NXRequest *rq) {
        
        NSLog(@"responseObject = %@",responseObject);
    } failure:^(NSError *error, NXRequest *rq) {
        
        NSLog(@"error = %@",[error userInfo]);
    }];
}

- (IBAction)startDownLoader:(id)sender {
    
    NXRequest * request = [[NXRequest alloc] initWithUrl:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg"];
    request.ingoreBaseUrl  =YES;
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"QQ_V5.4.0.dmg"];
    request.fileUrl = path;
    request.requstType = NXRequestTypeDownload;
    
    __weak typeof(self) weakSelf = self;
    
    [request startWith:^(double progress) {
        
        weakSelf.progressUI.progress = progress;
    } success:^(id responseObject, NXRequest *rq) {
        
        NSLog(@"下载成功");
    } failure:^(NSError *error, NXRequest *rq) {
        
        NSLog(@"error = %@",error);
    }];
     self.request = request;
}
- (IBAction)pauseDownLoad:(id)sender {
    
    [self.request pauseRequest];
}

- (IBAction)continueDownLoad:(id)sender
{
    
    [self.request resumeRequst];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
