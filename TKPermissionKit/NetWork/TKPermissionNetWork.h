//
//  TKPermissionNetWork.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKPermissionNetWork : NSObject

/**
 APP中的"无线数据"中选择关闭，系统会强制弹出一个面板进行网络设置
 注意：⚠️⚠️⚠️这个和第一次启动APP出现的授权管理不同，APP网络授权需要另想他法
 ⚠️⚠️⚠️completion:也不会有回调,只是用来做一个执行函数，即isAlert与completion没有作用
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(nullable void(^)(BOOL isAuth))completion;

@end

NS_ASSUME_NONNULL_END
