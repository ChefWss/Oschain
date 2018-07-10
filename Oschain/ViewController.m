//
//  ViewController.m
//  Oschain
//
//  Created by 王少帅 on 2018/6/29.
//  Copyright © 2018 王少帅. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self checkAppVersion];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#DD99AA"];
    
}

- (void)checkAppVersion
{
//    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:2];
//    param[@"appVersion"] = APP_VERSION;
//    param[@"appType"] = @2;
//    [[ApiService shareApiService] sendRequestType:kRequest_Post page:@"passport/version" param:param needToken:NO success:^(id data, NSInteger code, NSString *needNotice) {
//
//    } fail:^(NSError *error) {
//
//    }];
    

    //api
    [[ApiService shareApiService] loginByNumber:@"" Password:@"" success:^(id data, NSString *needNotice) {
        
    } fail:^(NSError *error) {
        
    }];

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
