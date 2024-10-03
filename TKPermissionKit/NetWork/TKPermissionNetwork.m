//
//  TKPermissionNetWork.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPermissionNetwork.h"
#import <CoreTelephony/CTCellularData.h>


@implementation TKPermissionNetwork



/**
 ⚠️⚠️功能：获取蜂窝移动网络权限状态。
 ⚠️⚠️提示：APP中的"无线数据"中选择关闭，系统会强制弹出一个面板进行网络设置。
 ⚠️⚠️注意：
 1. 只能获取状态，并不能申请权限。
 2. 这个和第一次启动APP出现的授权管理不同，APP网络授权需要另想他法！
 */
+ (void)authCellularStateWithCompletion:(nullable void(^)(TKPermissionNetworkCellularState state))completion
{
    if (@available(iOS 9.0, *) ){
        CTCellularData *cellularData = [[CTCellularData alloc]init];
        cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state)
        {
            TKPermissionNetworkCellularState _state = TKPermissionNetworkCellularStateUnknown;
            //获取联网状态
            switch (state)
            {
                case kCTCellularDataRestricted: NSLog(@"TKPermission:蜂窝移动网络权限：Restricrted");
                    _state = TKPermissionNetworkCellularStateRestricted;
                    break;
                case kCTCellularDataNotRestricted: NSLog(@"TKPermission:蜂窝移动网络权限：Not Restricted");
                    _state = TKPermissionNetworkCellularStateNotRestricted;
                    break;
                //未知，第一次请求
                case kCTCellularDataRestrictedStateUnknown: NSLog(@"TKPermission:蜂窝移动网络权限：Unknown");
                    _state = TKPermissionNetworkCellularStateUnknown;
                    break;
                default: break;
            };
            completion(_state);
        };
    }else{
        completion(TKPermissionNetworkCellularStateUnknown);
    }
}


@end
