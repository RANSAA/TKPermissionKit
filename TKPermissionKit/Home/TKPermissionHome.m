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

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    static id obj = nil;
    dispatch_once(&onceToken, ^{
        NSString *name = [NSString stringWithFormat:@"%@",self.class];
        Class class = NSClassFromString(name);
        obj = [[class alloc] init];
    });
    return obj;
}

- (void)jumpSetting
{
    [TKPermissionPublic alertPromptTips:TKPermissionString(@"访问住宅数据时需要您提供权限，去设置！")];
}

- (NSString *)name
{
    NSString *name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    if (!name) {
        name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    }
    return name;
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

    if (@available(iOS 13.0, *)) {
        [self checkAuth];
    } else {
    }
}

//ios13+ 直接检查权限状态
- (void)checkAuth API_AVAILABLE(ios(13.0))
{
    HMHomeManagerAuthorizationStatus status = self.homeManager.authorizationStatus;
    if (status != 0) {
        if (status == 5) {
            [self returnBlock:YES];
        }else if (status == 1){
            if (self.isAlert) {
                [self jumpSetting];
            }
            [self returnBlock:NO];
        }
    }
}


//ios13以下可以通过该方法，弹出授权框
- (void)checkAuthOldWithManager:(HMHomeManager *)manager
{
    if (manager.homes.count >0) {
        [self returnBlock:YES];
        self.homeManager.delegate = nil;
    }else{
        __weak HMHomeManager *weakHomeManager = manager;
        [manager addHomeWithName:[self name] completionHandler:^(HMHome * _Nullable home, NSError * _Nullable error) {
            if (!error) {
                [self returnBlock:YES];
                self.homeManager.delegate = nil;
            } else {
                // tips：出现错误，错误类型参考 HMError.h
                if (error.code == HMErrorCodeHomeAccessNotAuthorized) {
                    if (self.isAlert) {
                        [self jumpSetting];
                    }
                    [self returnBlock:NO];
                    self.homeManager.delegate = nil;
                    return ;
                } else {
                    [self returnBlock:YES];
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

#pragma mark HMHomeManagerDelegate
- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager
{
    if (@available(iOS 13.0, *)) {

    }else{
        [self checkAuthOldWithManager:manager];
    }
}

- (void)homeManager:(HMHomeManager *)manager didUpdateAuthorizationStatus:(HMHomeManagerAuthorizationStatus)status
API_AVAILABLE(ios(13.0))
{
    if (status == HMHomeManagerAuthorizationStatusDetermined) {//1-不允许
        if (self.isAlert) {
            [self jumpSetting];
        }
        [self returnBlock:NO];
    }else if(status == HMHomeManagerAuthorizationStatusAuthorized){
        [self returnBlock:YES];
    }else{
        [self returnBlock:YES];
    }
}

- (void)returnBlock:(BOOL)isAuth
{
    __weak TKPermissionBlock block = self.block;
    dispatch_async(dispatch_get_main_queue(), ^{
        block(isAuth);
    });
}

@end
