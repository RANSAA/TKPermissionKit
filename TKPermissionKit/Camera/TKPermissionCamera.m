//
//  TKPermissionCamera.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPermissionCamera.h"
#import "TKPermissionPublic.h"
#import <AVFoundation/AVFoundation.h>


@implementation TKPermissionCamera

+ (void)jumpSetting
{
    [TKPermissionPublic alertPromptTips:TKPermissionString(@"访问相机时需要您提供权限，去设置!")];
}

/**
 请求照相机权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                completion(YES);
            } else {
                if (isAlert) {
                    [self jumpSetting];
                }
                completion(NO);
            }
        });
    }];
}

/**
 查询是否获取了照相机权限
 **/
+ (BOOL)checkAuth
{
    BOOL isAuth = NO;
    if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusAuthorized) {
        isAuth = YES;
    }
    return isAuth;
}

@end
