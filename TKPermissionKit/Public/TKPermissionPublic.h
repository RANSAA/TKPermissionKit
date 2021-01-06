//
//  TKPermissionPublic.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

//block认证回调
typedef void(^TKPermissionBlock)(BOOL isAuth);
//多语言对应字符串获取
#define TKPermissionString(key) [TKPermissionPublic localizedStringForKey:key tab:@"InfoPlist"]


@interface TKPermissionPublic : NSObject

/** 直接从bundle文件中读取指定string，而获取国际化字符串*/
+ (NSString *)localizedStringForKey:(NSString *)key tab:(NSString *)tab;


#pragma mark alert

/// 包装UIAlertController, 具有两个按钮
/// @param title 标题
/// @param msg 内容
/// @param leftTitle 左边按钮文字
/// @param rightTitle 右边按钮文字
+ (void)alertTitle:(NSString *)title msg:(NSString *)msg leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle;

/// 包装UIAlertController,只有一个按钮
/// @param title 标题
/// @param msg 内容
/// @param actionTitle 按钮文字
+ (void)alertActionTitle:(NSString *)title msg:(NSString *)msg actionTitle:(NSString *)actionTitle;

/**
 权限提示alert，两个按钮
 */
+ (void)alertPromptTips:(NSString *)msg;

/**
 简单弹窗，一个按钮
 */
+ (void)alertTips:(NSString *)msg;


@end

NS_ASSUME_NONNULL_END
