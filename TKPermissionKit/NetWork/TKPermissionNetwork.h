//
//  TKPermissionNetWork.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKPermissionPublic.h"

NS_ASSUME_NONNULL_BEGIN



//蜂窝移动网络权限状态枚举
typedef NS_ENUM(NSInteger, TKPermissionNetworkCellularState){
    TKPermissionNetworkCellularStateUnknown = -1,            //蜂窝移动网络权限：未知
    TKPermissionNetworkCellularStateRestricted = 0,          //蜂窝移动网络权限：访问受限制
    TKPermissionNetworkCellularStateNotRestricted = 1,       //蜂窝移动网络权限：不受限制
};


@interface TKPermissionNetwork : NSObject





/**
 ⚠️⚠️功能：获取蜂窝移动网络权限状态。
 ⚠️⚠️提示：APP中的"无线数据"中选择关闭，系统会强制弹出一个面板进行网络设置。
 ⚠️⚠️注意：
 1. 只能获取状态，并不能申请权限。
 2. 这个和第一次启动APP出现的授权管理不同，APP网络授权需要另想他法！
 */
+ (void)authCellularStateWithCompletion:(nullable void(^)(TKPermissionNetworkCellularState state))completion;

@end

NS_ASSUME_NONNULL_END
