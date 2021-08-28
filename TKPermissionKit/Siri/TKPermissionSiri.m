//
//  TKPermissionSiri.m
//  TKPermissionKitDemo
//
//  Created by PC on 2021/8/28.
//  Copyright © 2021 mac. All rights reserved.
//

#import "TKPermissionSiri.h"
#import <Intents/Intents.h>

@implementation TKPermissionSiri


+ (void)jumpSetting
{
    [TKPermissionPublic alertPromptTips:TKPermissionString(@"访问Siri时需要您提供权限，去设置!")];
}

+ (void)alertAction
{
    [TKPermissionPublic alertTips:TKPermissionString(@"当前系统不支持Siri")];
}

/**
请求Siri权限
isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
isAuth:  回调，用户是否申请权限成功！
**/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    if (@available(iOS 10.0, *)) {
        [INPreferences requestSiriAuthorization:^(INSiriAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == INSiriAuthorizationStatusAuthorized) {
                    completion(YES);
                }else{
                    if (isAlert) {
                        [self jumpSetting];
                    }
                    completion(NO);
                }
            });
        }];
    }else{
        [self  alertAction];
        completion(NO);
    }
}


/**
 检查Siri权限
 */
+ (BOOL)checkAuth
{
    if (@available(iOS 10.0, *)) {
        INSiriAuthorizationStatus status = [INPreferences siriAuthorizationStatus];
        if (status == INSiriAuthorizationStatusAuthorized) {
            return YES;;
        }else{
            return NO;
        }
    }else{
        return NO;
    }

}


@end
