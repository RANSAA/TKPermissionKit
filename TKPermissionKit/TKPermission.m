//
// PrivacyPermission.h
//
//  Created by sayaDev on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPermission.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <EventKit/EventKit.h>
#import <Contacts/Contacts.h>
#import <Speech/Speech.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreTelephony/CTCellularData.h>
#import <HomeKit/HomeKit.h>
#import <HealthKit/HealthKit.h>
#import <CoreMotion/CoreMotion.h>

static TKPermission *_instance = nil;
typedef void (^AuthCompletion)(BOOL isAuth);

@interface TKPermission ()<CLLocationManagerDelegate,HMHomeManagerDelegate>
@property (nonatomic, strong) CLLocationManager         *locationManager;       // 定位
@property (nonatomic, strong) CBCentralManager          *centralManager;        // 蓝牙
@property (nonatomic, strong) HKHealthStore             *healthStore;           // 健康
@property (nonatomic, strong) HMHomeManager             *homeManager;           // home
@property (nonatomic, strong) CMMotionActivityManager   *cmManager;             // 运动
@property (nonatomic, strong) NSOperationQueue          *motionActivityQueue;   // 运动
@property (nonatomic, copy  ) AuthCompletion authCompletion;//认证成功回调
@end

@implementation TKPermission

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return _instance;
}



/**
 请求应用权限
 type:权限类型
 completion:授权回调
 isAuth:权限请求(查询)成功或者失败
 **/
- (void)authPermissionWithType:(PermissionAuthType)type completion:(void(^)(BOOL isAuth))completion
{
    switch (type) {
        case PermissionAuthTypePhoto://相册
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    completion(YES);
                }else{
                    completion(NO);
                }
            }];
        }
            break;
        case PermissionAuthTypeCamera://相机
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    completion(YES);
                } else {
                    completion(NO);
                }
            }];
        }
            break;
        case PermissionAuthTypeMedia://媒体资料库
        {
            if (@available(iOS 9.3, *)) {
                [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
                    if (status == MPMediaLibraryAuthorizationStatusAuthorized) {
                        completion(YES);
                    } else{
                        completion(NO);
                    }
                }];
            } else {
                NSLog(@"TKPermission:当前系统版本不支持媒体资料库，请升级iOS版本(iOS9.3+),(或者请更改权限获取方式)");
                completion(NO);
            }
        }
            break;
        case PermissionAuthTypeMicrophone://麦克风
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                if (granted) {
                    completion(YES);
                } else {
                    completion(NO);
                }
            }];
        }
            break;
        case PrivacyPermissionTypeLocationAlways://定位-始终使用
        {
            if ([CLLocationManager locationServicesEnabled]) {
                self.locationManager = [[CLLocationManager alloc]init];
                self.locationManager.delegate = self;
                [self.locationManager requestAlwaysAuthorization];
            }
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
                completion(YES);
            }else {
                completion(NO);
            }
        }
            break;
        case PrivacyPermissionTypeLocationWhen://定位-使用期间
        {
            if ([CLLocationManager locationServicesEnabled]) {
                self.locationManager = [[CLLocationManager alloc]init];
                self.locationManager.delegate = self;
                [self.locationManager requestWhenInUseAuthorization];
            }
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
                completion(YES);
            }else {
                completion(NO);
            }
        }
            break;
        case PermissionAuthTypePushNotification://推送
        {
            UIApplication *application = [UIApplication sharedApplication];
            if (@available(iOS 10.0, *)) {
                UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                UNAuthorizationOptions types=UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
                [center requestAuthorizationWithOptions:types completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (granted) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                                //
                            }];
                        });
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) { }];
                        });
                    }
                }];
            } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
                [application registerUserNotificationSettings:
                 [UIUserNotificationSettings settingsForTypes:
                  (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                   categories:nil]];
                [application registerForRemoteNotifications];
            }
#pragma clang diagnostic pop
        }
            break;
        case PermissionAuthTypeSpeech://语音识别
        {
            if (@available(iOS 10.0, *)) {
                [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                    if(status == SFSpeechRecognizerAuthorizationStatusAuthorized){
                        completion(YES);
                    }else{
                        completion(NO);
                    }
                }];
            } else {
                NSLog(@"TKPermission:当前系统版本不支持语音识别，请升级iOS版本(iOS10.0+)");
                completion(NO);
            }
        }
            break;
        case PermissionAuthTypeCalendar://日历
        {
            EKEventStore *store = [[EKEventStore alloc] init];
            [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    completion(YES);
                } else {
                    completion(NO);
                }
            }];
        }
            break;
        case PermissionAuthTypeContact://通讯录
        {
            if (@available(iOS 9.0, *)) {
                CNContactStore *contactStore = [[CNContactStore alloc] init];
                [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (granted) {
                        completion(YES);
                    } else {
                        completion(NO);
                    }
                }];
            } else {
                ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
                ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                    if (granted) {
                        completion(YES);
                    }else{
                        completion(NO);
                    }
                });
            }
        }
            break;
        case PermissionAuthTypeReminder://提醒事项
        {
            EKEventStore *eventStore = [[EKEventStore alloc] init];
            [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    completion(YES);
                } else {
                    completion(NO);
                }
            }];
        }
            break;
        case PermissionAuthTypeNetWork://应用移动蜂窝网络权限检测
        {
            if (@available(iOS 9.0, *)) {
                CTCellularData *cellularData = [[CTCellularData alloc]init];
                cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state)
                {
                    //获取联网状态
                    switch (state)
                    {
                        case kCTCellularDataRestricted: NSLog(@"TKPermission:蜂窝移动网络权限：Restricrted"); break;
                        case kCTCellularDataNotRestricted: NSLog(@"TKPermission:蜂窝移动网络权限：Not Restricted"); break;
                            //未知，第一次请求
                        case kCTCellularDataRestrictedStateUnknown: NSLog(@"TKPermission:蜂窝移动网络权限：Unknown"); break;
                        default: break;
                    };
                };
            } else {
                // 不需要网络权限检测
                completion(YES);
            }
        }
            break;
        case PermissionAuthTypeHealth://健康Health
        {
            if ([HKHealthStore isHealthDataAvailable]) {
                if (!self.healthStore) {
                    self.healthStore = [[HKHealthStore alloc] init];
                }
                //以步数为例子
                HKQuantityType *stepCountType   = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//                HKQuantityType *heightType      = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
//                HKQuantityType *weightType      = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
//                HKQuantityType *temperatureType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
//                HKQuantityType *distance        = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
//                HKQuantityType *activeEnergyType= [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
                NSSet *write = [NSSet setWithObjects:stepCountType,nil];

//                HKCharacteristicType *birthdayType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
//                HKCharacteristicType *sexType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];

                NSSet *read  = [NSSet setWithObjects:stepCountType,nil];;
                HKHealthStore *health = [[HKHealthStore alloc] init];
                [health requestAuthorizationToShareTypes:write readTypes:read completion:^(BOOL success, NSError * _Nullable error) {
                    HKAuthorizationStatus status = [self.healthStore authorizationStatusForType:stepCountType];
                    if (HKAuthorizationStatusSharingAuthorized == status) {
                        completion(YES);
                    }else{
                        completion(NO);
                    }
                }];
            }else{
                NSLog(@"TKPermission:当前设备不支持Health");
                completion(NO);
            }
        }
            break;
        case PermissionAuthTypeSportsAndFitness://运动与健身
        {
            if([CMMotionActivityManager isActivityAvailable]){
                if (@available(iOS 11.0, *)) {
                    NSInteger status = [CMMotionActivityManager authorizationStatus];
                    if (status == 3) {//允许
                        completion(YES);
                    }else if (status == 2){//禁止
                        NSLog(@"TKPermission:运动与健身禁止授权");
                        completion(NO);
                    }else if (status == 0){//未弹框
                        self.cmManager = [[CMMotionActivityManager alloc] init];
                        self.motionActivityQueue = [[NSOperationQueue alloc] init];
                        [self.cmManager startActivityUpdatesToQueue:self.motionActivityQueue withHandler:^(CMMotionActivity *activity) {
                            [self.cmManager stopActivityUpdates];
                            completion(YES);
                        }];
                    }else{//系统禁止授权
                        NSLog(@"TKPermission:运动与健身系统禁止授权");
                        completion(NO);
                    }
                } else {
                    self.cmManager = [[CMMotionActivityManager alloc] init];
                    self.motionActivityQueue = [[NSOperationQueue alloc] init];
                    [self.cmManager startActivityUpdatesToQueue:self.motionActivityQueue withHandler:^(CMMotionActivity *activity) {
                        [self.cmManager stopActivityUpdates];
                    }];
                }
            }else{
                NSLog(@"TKPermission:当前设备不支持运动与健身");
                completion(NO);
            }
        }
            break;
        case PermissionAuthTypeHomeKit://HomeKit
        {
            self.authCompletion = completion;
            self.homeManager = [[HMHomeManager alloc] init];
            self.homeManager.delegate = self;
        }
            break;
    }
}


#pragma mark - HMHomeManagerDelegate
- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager{
    if (manager.homes.count > 0) {
        self.authCompletion(YES);
        self.homeManager.delegate = nil;
    } else {
        __weak HMHomeManager *weakHomeManager = manager;
        [manager addHomeWithName:@"Test Home" completionHandler:^(HMHome * _Nullable home, NSError * _Nullable error) {
            NSLog(@"error:%@    home:%@",error,home);
            if (!error) {
                self.authCompletion(YES);
            } else {
                // tips：出现错误，错误类型参考 HMError.h
                if (error.code == HMErrorCodeHomeAccessNotAuthorized) {
                    NSLog(@"TKPermission:HomeKit 用户拒绝!!");
                     self.authCompletion(NO);
                    self.homeManager.delegate = nil;
                    return ;
                } else {
                    NSLog(@"TKPermission:HomeKit HOME_ERROR:%ld,%@",error.code, error.localizedDescription);
                    self.authCompletion(YES);
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
