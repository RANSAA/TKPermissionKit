//
//  TKPermissionHome.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPermissionHome.h"
#import "TKPermissionPublic.h"
#import <HomeKit/HomeKit.h>

@interface TKPermissionHome ()<HMHomeManagerDelegate>
@property (nonatomic, strong) HMHomeManager *homeManager;
@property (nonatomic, copy  ) TKPermissionBlock block;
@property (nonatomic, assign) BOOL isAlert;
@end

@implementation TKPermissionHome

+ (id)shared
{
    static dispatch_once_t onceToken;
    static TKPermissionHome *obj = nil;
    dispatch_once(&onceToken, ^{
        obj = [TKPermissionHome new];
    });
    return obj;
}

- (void)jumpSetting
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [TKPermissionPublic alertTitle:@"权限提示" msg:@"访问住宅数据时需要您提供权限，请设置！"];
    });
}


- (HMHomeManager *)homeManager
{
    if (!_homeManager) {
        _homeManager = [[HMHomeManager alloc] init];
    }
    return _homeManager;
}

/**
 请求HomeKit住宅数据权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
- (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    self.block = completion;
    self.isAlert = isAlert;

    self.homeManager.delegate = self;
}

#pragma mark HMHomeManagerDelegate
- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager
{
    if (manager.homes.count > 0) {
        self.block(YES);
        self.homeManager.delegate = nil;
    } else {
        __weak HMHomeManager *weakHomeManager = manager;
        [manager addHomeWithName:@"Test Home" completionHandler:^(HMHome * _Nullable home, NSError * _Nullable error) {
            if (!error) {
                self.block(YES);
                self.homeManager.delegate = nil;
            } else {
                // tips：出现错误，错误类型参考 HMError.h
                if (error.code == HMErrorCodeHomeAccessNotAuthorized) {
                    if (self.isAlert) {
                        [self jumpSetting];
                    }
                    self.block(NO);
                    self.homeManager.delegate = nil;
                    return ;
                } else {
                    self.block(YES);
                    self.homeManager.delegate = nil;
                }
            }
            if (home) {
                [weakHomeManager removeHome:home completionHandler:^(NSError * _Nullable error) {
                }];
            }
        }];
    }
}



@end
