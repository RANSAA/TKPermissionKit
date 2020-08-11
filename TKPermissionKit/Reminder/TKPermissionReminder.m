//
//  TKPermissionReminder.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPermissionReminder.h"
#import "TKPermissionPublic.h"
#import <EventKit/EventKit.h>

@implementation TKPermissionReminder

+ (void)jumpSetting
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [TKPermissionPublic alertTitle:TKPermissionString(@"权限提示") msg:TKPermissionString(@"使用提醒事项时需要您提供权限，去设置!")];
    });
}

/**
 请求提醒事项权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            completion(YES);
        } else {
            if (isAlert) {
                [self jumpSetting];
            }
            completion(NO);
        }
    }];
}

/**
 查询是否获取了提醒事项权限
 **/
+ (BOOL)checkAuth
{
    BOOL isAuth = NO;
    if ([EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder] == EKAuthorizationStatusAuthorized) {
        isAuth = YES;
    }
    return isAuth;
}


@end
