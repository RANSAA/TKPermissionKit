# TKPermissionKit

#### 介绍
TKPermissionKit应用权限获取


#### 权限支持
*  相册
*  相机
*  媒体资料库
*  蓝牙
*  麦克风
*  定位-始终使用
*  定位-使用期间
*  语音识别
*  日历
*  通讯录
*  提醒事项
*  推送
*  应用联网权限检测
*  家庭HomeKit
*  运动与健身   PS:iOS11.0+回调才会有权限成功与失败状态，小于iOS11的版本也能请求到权限，但是不会回调(即不能检测到授权状态，只能弹出授权alert)
*  健康Health    PS:由于健康中的数据类型很多，并且都需要相关权限所以，不建议使用，用户可以根据该框架进行仿照以达到实际要求
*  Files



#### 引用方式

1.全部导入：
```
pod 'TKPermissionKit'
```
2.按需导入，推荐此方式：
```
pod 'TKPermissionKit/Photo'                 #相册
pod 'TKPermissionKit/Camera '               #相机
pod 'TKPermissionKit/Media'                 #媒体资料库
pod 'TKPermissionKit/Bluetooth'             #蓝牙
pod 'TKPermissionKit/Microphone'            #麦克风
pod 'TKPermissionKit/Speech'                #语音识别
pod 'TKPermissionKit/LocationWhen'          #定位-应用使用期间
pod 'TKPermissionKit/LocationAlways'        #定位-始终
pod 'TKPermissionKit/Notification'          #通知
pod 'TKPermissionKit/Contacts'              #通讯录
pod 'TKPermissionKit/Calendar'              #日历
pod 'TKPermissionKit/Reminder'              #提醒事项
pod 'TKPermissionKit/NetWork'               #网路--
pod 'TKPermissionKit/Motion'                #运动于健身
pod 'TKPermissionKit/Home'                  #homeKit
pod 'TKPermissionKit/Health'                #健康
pod 'TKPermissionKit/FileAndFolders'        #文件
```

#### 使用方法
1.直接调用类方法

```
[TKPermissionPhoto authWithAlert:YES completion:^(BOOL isAuth) {
    if (isAuth) {
        NSLog(@"相册权限获取成功！");
    }else{
        NSLog(@"相册权限获取失败");
    }
}];
```

2.调用单利中的方法

```
[[TKPermissionBluetooth shared] authWithAlert:YES completion:^(BOOL isAuth) {
    if (isAuth) {
        NSLog(@"蓝牙权限获取成功！");
    }else{
        NSLog(@"蓝牙权限获取失败");
    }
}];
```

3.注意
```
completion:^(BOOL isAuth) {
    //这个回调都被切换到了主线程
}
```


#### 网络权限的监控和判断
本框架中的网络检测模块基本上没有作用，可以使用[ZYNetworkAccessibility](https://github.com/ziecho/ZYNetworkAccessibility)

#### 注意
使用具体模块时，可以查看对应模块头文件中的使用说明与注意事项！

#### 其它
1. https://github.com/EchoZuo/ECAuthorizationTools
2. https://github.com/skooal/PrivacyPermission
3. https://github.com/lixiang1994/PermissionKit    (swift) 它的设计模式可以学一学

