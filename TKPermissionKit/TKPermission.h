//
// PrivacyPermission.h
//
//  Created by sayaDev on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

/**
 PS:使用该框架时注意Deployment Target 的版本，即仔细查看PermissionAuthType对应的版本好
 **/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 权限描述:
 Privacy - Photo Library Usage Description                          需要您的同意，才能访问相册
 Privacy - Photo Library Additions Usage Description (添加照片)       需要您的同意，才能添加照片
 Privacy - Camera Usage Description                                 需要您的同意，才能访问相机
 Privacy - Location Always and When In Use Usage Description        需要您的同意，才能获取定位信息
 Privacy - Location When In Use Usage Description                   需要您的同意，才能在使用期间访问位置
 Privacy - Location Always Usage Description                        需要您的同意，才能始终访问位置
 Privacy - Media Library Usage Description                          需要您的同意，才能访问媒体资料库
 Privacy - Microphone Usage Description                             需要您的同意，才能访问麦克风
 Privacy - Bluetooth Peripheral Usage Description                   需要您的同意，才能访问蓝牙
 Privacy - Speech Recognition Usage Description                     需要您的同意，才能访问语音识别
 Privacy - Contacts Usage Description                               需要您的同意，才能访问通讯录
 Privacy - Calendars Usage Description                              需要您的同意，才能访问日历
 Privacy - Reminders Usage Description                              需要您的同意，才能访问提醒事项
 Privacy - Motion Usage Description                                 需要您的同意，才能访问运动与健身
 Privacy - Health Share Usage Description                           需要您的同意，才能访问健康分享
 Privacy - Health Update Usage Description                          需要您的同意，才能访问健康更新
 Privacy - HomeKit Usage Description                                需要您的同意，才能访问HomeKit
 Privacy - Siri Usage Description                                   需要您的同意，才能访问Siri
 Privacy - TV Provider Usage Description                            需要您的同意，才能访问AppleTV

 **/


/**
 获取权限类型
 **/

typedef NS_ENUM(NSInteger,PermissionAuthType){
    PermissionAuthTypePhoto = 1,//相册,ios8.0
    PermissionAuthTypeCamera,//相机,ios7.0
    PermissionAuthTypeMedia,//媒体资料库,ios9.3
    PermissionAuthTypeMicrophone,//麦克风,ios7.0
    PrivacyPermissionTypeLocationAlways,//定位-始终使用
    PrivacyPermissionTypeLocationWhen,//定位-使用期间
    PermissionAuthTypeSpeech,//语音识别 ios10
    PermissionAuthTypeCalendar,//日历,ios6.0
    PermissionAuthTypeContact,//通讯录
    PermissionAuthTypeReminder,//提醒事项，iOS6.0
    PermissionAuthTypeNetWork,//应用联网权限检测-只能检测蜂窝移动网络状态

    PermissionAuthTypeSportsAndFitness,//运动与健身7.0+  iOS11.0+回调才会有权限成功与失败状态，小于iOS11的版本也能请求到权限，但是不会回调(即不能检测到授权状态，只能弹出授权alert)
    PermissionAuthTypeHealth,//健康Health8.0+   由于健康中的数据类型很多，并且都需要相关权限所以，不建议使用，用户可以根据该框架进行仿照以达到实际要求
    PermissionAuthTypeHomeKit,//家庭HomeKit8.0+

    PermissionAuthTypePushNotification//推送-基本上可以不使用
};





@interface TKPermission : NSObject

+ (instancetype)shared;

/**
 请求应用权限
 type:权限类型
 completion:授权回调
            isAuth:权限请求(查询)成功或者失败
 **/
- (void)authPermissionWithType:(PermissionAuthType)type completion:(void(^)(BOOL isAuth))completion;

@end
