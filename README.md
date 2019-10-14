# TKPermissionKitDemo

#### 介绍
TKPermissionKitDemo权限获取


#### 权限支持
1. 相册
2. 相机
3. 媒体资料库
4. 蓝牙
5. 麦克风
6. 定位-始终使用
7. 定位-使用期间
8. 语音识别
9. 日历
10. 通讯录
11. 提醒事项
12. 推送
13. 应用联网权限检测
14. 家庭HomeKit
15. 运动与健身   PS:iOS11.0+回调才会有权限成功与失败状态，小于iOS11的版本也能请求到权限，但是不会回调(即不能检测到授权状态，只能弹出授权alert)
16. 健康Health    PS:由于健康中的数据类型很多，并且都需要相关权限所以，不建议使用，用户可以根据该框架进行仿照以达到实际要求

#### 引用方式
引入所有的功能模块：

  pod 'TKPermissionKit'


不推荐直接引用所以功能模块，除非你的项目中用到了所有的模块，否则建议你按需求引入具体权限请求模块，它们分别为：
1. TKPermissionKit/Photo              #相册
2. TKPermissionKit/Camera             #相机
3. TKPermissionKit/Media              #媒体资料库
4. TKPermissionKit/Bluetooth          #蓝牙
5. TKPermissionKit/Microphone         #麦克风
6. TKPermissionKit/LocationWhen       #定位-应用使用期间
7. TKPermissionKit/LocationAlways     #定位-始终
8. TKPermissionKit/Notification       #通知
9. TKPermissionKit/Speech             #语音识别
10. TKPermissionKit/Contacts          #通讯录
11. TKPermissionKit/Calendar          #日历
12. TKPermissionKit/Reminder          #提醒事项
13. TKPermissionKit/NetWork           #网路--
14. TKPermissionKit/Motion            #运动于健身
15. TKPermissionKit/Home              #homeKit
16. TKPermissionKit/Health            #健康

#### 注意
使用具体模块时，注意查看对应模块头文件中的使用说明与注意事项！

#### 其它
1.      https://github.com/EchoZuo/ECAuthorizationTools
2.      https://github.com/skooal/PrivacyPermission
3.      https://github.com/lixiang1994/PermissionKit    (swift)

