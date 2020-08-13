//
//  TKPermissionSpeech.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPermissionSpeech.h"
#import "TKPermissionPublic.h"
#import <Speech/Speech.h>


@implementation TKPermissionSpeech

+ (void)jumpSetting
{
    [TKPermissionPublic alertPromptTips:TKPermissionString(@"使用语音识别功能时需要您提供权限，去设置!")];
}

+ (void)alertAction
{
    [TKPermissionPublic alertTips:TKPermissionString(@"要使用语音识别功能，系统版本需要iOS10及以上！")];
}

/**
 请求Speech 语音识别 权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    if (@available(iOS 10.0, *)) {
        [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
                    completion(YES);
                }else{
                    if (status == SFSpeechRecognizerAuthorizationStatusDenied && isAlert) {
                        [self jumpSetting];
                    }
                    completion(NO);
                }
            });
        }];
    } else {
        [self alertAction];
        completion(NO);
    }
}

/**
 查询是否获取了Speech 语音识别 权限
 **/
+ (BOOL)checkAuth
{
    BOOL isAuth = NO;
    if (@available(iOS 10.0, *)) {
        if ([SFSpeechRecognizer authorizationStatus] == SFSpeechRecognizerAuthorizationStatusAuthorized) {
            isAuth = YES;
        }
    } else {
        NSLog(@"⚠️⚠️⚠️要使用语音识别功能，系统版本需要iOS10及以上！");
    }
    return isAuth;
}

@end
