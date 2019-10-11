//
//  TKPermissionPhoto.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 功能：相册权限获取与请求
 要求：iOS8.0+


 权限描述:
 Privacy - Photo Library Usage Description                          需要您的同意，才能访问相册
 Privacy - Photo Library Additions Usage Description (添加照片)       需要您的同意，才能添加照片

 **/


NS_ASSUME_NONNULL_BEGIN

@interface TKPermissionPhoto : NSObject

/**
 请求相册权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;

/**
 查询是否获取了相册权限
 **/
+ (BOOL)checkAuth;

@end

NS_ASSUME_NONNULL_END
