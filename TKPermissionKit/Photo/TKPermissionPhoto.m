//
//  TKPermissionPhoto.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPermissionPhoto.h"
#import <Photos/Photos.h>


@implementation TKPermissionPhoto

static bool safeLock = NO;//防止连续请求lock

+ (void)jumpSetting
{
    [TKPermissionPublic alertPromptTips:TKPermissionString(@"访问相册时需要您提供权限，去设置!")];
}

/**
 请求相册权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    [self authWithAlert:isAlert level:TKPhotoAccessLevelReadWrite completion:completion];
}

/**
 请求相册权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 level:   相册访问权限,限制类型:只读/读写（iOS14+才有效）
 isAuth:  回调，用户是否申请权限成功！
 PS:获取相册的读写权限/只添加权限由level决定
 **/
+ (void)authWithAlert:(BOOL)isAlert level:(TKPhotoAccessLevel)level completion:(void(^)(BOOL isAuth))completion
{
    if (safeLock) {
        return;
    }
    safeLock = YES;

    if(@available(iOS 14.0, *)){
        PHAccessLevel type = PHAccessLevelReadWrite;
        if (level == TKPhotoAccessLevelOnlyAdd) {
            type = PHAccessLevelAddOnly;
        }
        [PHPhotoLibrary requestAuthorizationForAccessLevel:type handler:^(PHAuthorizationStatus status) {
            [self handler:status Alert:isAlert completion:completion];
        }];
    }else{
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            [self handler:status Alert:isAlert completion:completion];
        }];
    }
}



+ (void)handler:(PHAuthorizationStatus)status Alert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (status == PHAuthorizationStatusAuthorized) {
            completion(YES);
        }else{
            if (@available(iOS 14.0, *)) {
                if (status == PHAuthorizationStatusLimited) {
                    completion(YES);
                }else{
                    if (isAlert) {
                        [self jumpSetting];
                    }
                    completion(NO);
                }
            }else{
                if (isAlert) {
                    [self jumpSetting];
                }
                completion(NO);
            }
        }
        safeLock = NO;
    });
}



/**
 查询是否获取了相册权限
 */
+ (BOOL)checkAuthWith:(TKPhotoAccessLevel)level
{
    BOOL isAuth = NO;
    if (@available(iOS 14.0, *)) {
        if (level == TKPhotoAccessLevelReadWrite) {
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatusForAccessLevel:PHAccessLevelReadWrite];
            if (status == PHAuthorizationStatusAuthorized || status == PHAuthorizationStatusLimited) {
                isAuth = YES;
            }
        }else{
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatusForAccessLevel:PHAccessLevelAddOnly];
            if (status == PHAuthorizationStatusAuthorized || status == PHAuthorizationStatusLimited) {
                isAuth = YES;
            }
        }
    }else{
        if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
            isAuth = YES;
        }
    }
    return isAuth;
}


@end
