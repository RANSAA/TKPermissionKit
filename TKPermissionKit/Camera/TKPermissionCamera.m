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

/**
 检查前置摄像头是否可用
 */
+ (BOOL)checkCameraFrontAvailableWithAlert:(BOOL)isAlert
{
    BOOL isAvailable = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    if (!isAvailable && isAlert) {
        [TKPermissionPublic alertTips:TKPermissionString(@"前置摄像头无法使用")];
    }
    return isAvailable;
}

/**
 检测后置摄像头是否可用
 */
+ (BOOL)checkCameraRearAvailableWithAlert:(BOOL)isAlert
{
    BOOL isAvailable = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isAvailable && isAlert) {
        [TKPermissionPublic alertTips:TKPermissionString(@"后置摄像头无法使用")];
    }
    return isAvailable;
}

/**
 提示照相机无法使用
 PS:前置或者后置无法使用就提示
 */
+ (void)alertCameraError
{
    BOOL err = NO;
    BOOL isRear =  [TKPermissionCamera checkCameraRearAvailableWithAlert:NO];
    BOOL isFront = [TKPermissionCamera checkCameraFrontAvailableWithAlert:NO];
    if (!isRear || isFront) {
        err = YES;
    }
    if (err) {
        [TKPermissionPublic alertTips:TKPermissionString(@"相机无法使用")];
    }
}


@end
