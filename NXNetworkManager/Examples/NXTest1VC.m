//
//  NXTest1VC.m
//  NXNetworkManager
//
//  Created by yoyo on 2017/9/14.
//  Copyright © 2017年 yoyo. All rights reserved.
//

#import "NXTest1VC.h"
#import "PLRequest.h"
@interface NXTest1VC ()

@end

@implementation NXTest1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)getActionHanlder:(UIButton *)sender {
    
    double time = [[NSDate date] timeIntervalSince1970];
    PLRequest * request = [[PLRequest alloc] initWithAPIPath:@"check_version.json"];
    request.params.addDouble(time,@"time");
    [request startWithSucces:^(id responseObject, NXRequest *rq) {
        
    } failure:^(NSError *error, NXRequest *rq) {
        
    }];
}
- (IBAction)postActionHandler:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
