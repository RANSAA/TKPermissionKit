//
//  ViewController.m
//  TKPermissionDemo
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ViewController.h"
#import "TKPermission.h"
#import <MediaPlayer/MediaPlayer.h>
#import <CoreTelephony/CTCellularData.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.



    MPVolumeSettingsAlertHide();
    [self get];
    [self test];

    [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self get];
    }];
}

- (void)test
{

    CTCellularData *cellularData = [[CTCellularData alloc] init];
    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
        //获取联网权限状态
        switch (state) {
            case kCTCellularDataRestricted:
                NSLog(@"Restricrted");
                break;

            case kCTCellularDataNotRestricted:
                NSLog(@"Not Restricted");
                break;

                //未知，第一次请求
            case kCTCellularDataRestrictedStateUnknown:
                NSLog(@"Unknown");
                break;

            default:
                NSLog(@"cellularData:%ld",state);
                break;
        };
    };
}

- (void)get
{
    NSURL *url = [NSURL URLWithString:@"http://www.cocoachina.com/cms/wap.php?action=article&id=24389"];
    NSURLSession *setion = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [setion dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"data:%@",data);
    }];
    [task resume];
}


@end
