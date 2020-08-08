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
/**
 包装UIAlertController，跳转进入设置页面，进行权限设置
 alert时会自动切换，进入主线程
 **/
+ (void)alertTitle:(NSString *)title msg:(NSString *)msg;

/**
 包装UIAlertController，简单的alert action
 ps:只是一个简单的弹窗
 **/
+ (void)alertActionTitle:(NSString *)title msg:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
