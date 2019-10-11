//
//  TKPermissionSpeech.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 功能：Speech 语音识别权限获取与请求
 要求：iOS10.0+
 注意：Speech语音识别功能要求iOS10.0+

 权限描述:
 Privacy - Speech Recognition Usage Description                     需要您的同意，才能访问语音识别
 
 **/

@interface TKPermissionSpeech : NSObject

/**
 请求Speech 语音识别 权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;

/**
 查询是否获取了Speech 语音识别 权限
 **/
+ (BOOL)checkAuth;

@end

NS_ASSUME_NONNULL_END
