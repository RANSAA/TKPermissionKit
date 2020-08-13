//
//  TKPermissionMotion.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPermissionMotion.h"
#import "TKPermissionPublic.h"
#import <CoreMotion/CoreMotion.h>


@interface TKPermissionMotion ()
@property (nonatomic, strong) CMMotionActivityManager   *cmManager;             // 运动
@property (nonatomic, strong) NSOperationQueue          *motionActivityQueue;   // 运动
@property (nonatomic, copy  ) TKPermissionBlock block;
@property (nonatomic, assign) BOOL isAlert;
@end

@implementation TKPermissionMotion

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    static id obj = nil;
    dispatch_once(&onceToken, ^{
        NSString *name = [NSString stringWithFormat:@"%@",self.class];
        Class class = NSClassFromString(name);
        obj = [[class alloc] init];
    });
    return obj;
}

- (void)jumpSetting
{
    [TKPermissionPublic alertPromptTips:TKPermissionString(@"访问运动与健身时需要您提供权限，去设置！")];
}

- (void)alertAction
{
    [TKPermissionPublic alertTips:TKPermissionString(@"当前设备不支持运动与健身！")];
}


/**
 请求运动与健身权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
- (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    self.block = completion;
    self.isAlert = isAlert;
    if ([CMMotionActivityManager isActivityAvailable]) {
        if (@available(iOS 11.0, *)) {
            NSInteger status = [CMMotionActivityManager authorizationStatus];
            if (status == CMAuthorizationStatusAuthorized) {
                [self returnBlock:YES];
            }else if (status == CMAuthorizationStatusDenied){
                if (isAlert) {
                    [self jumpSetting];
                }
                [self returnBlock:NO];
            }else{//申请权限
                [self queryActivityStarting];
            }
        } else {
            [self queryActivityStarting];
        }
    }else{
        [self alertAction];
        [self returnBlock:NO];
    }
}

/**
 通过查询CMMotionActivityManager来请求，获取权限
 **/
- (void)queryActivityStarting
{
    self.cmManager = [[CMMotionActivityManager alloc] init];
    self.motionActivityQueue = [[NSOperationQueue alloc] init];
    NSDate *beginDate = [NSDate new];
    NSDate *endDate   = [beginDate dateByAddingTimeInterval:3600];
    [self.cmManager queryActivityStartingFromDate:beginDate toDate:endDate toQueue:self.motionActivityQueue withHandler:^(NSArray<CMMotionActivity *> * _Nullable activities, NSError * _Nullable error) {
        if (error) {
            if (self.isAlert) {
                [self jumpSetting];
            }
            [self returnBlock:NO];
        }else{
            [self returnBlock:YES];
        }
        [self.motionActivityQueue cancelAllOperations];
        self.motionActivityQueue = nil;
        [self.cmManager stopActivityUpdates];
        self.cmManager = nil;
    }];
}


- (void)returnBlock:(BOOL)isAuth
{
    __weak TKPermissionBlock block = self.block;
    dispatch_async(dispatch_get_main_queue(), ^{
        block(isAuth);
    });
}

@end
