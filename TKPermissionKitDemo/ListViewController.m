//
//  ListViewController.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ListViewController.h"
#import "TKPermission.h"
#import <CoreTelephony/CTCellularData.h>
#import <CoreLocation/CoreLocation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource,CBCentralManagerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (copy  , nonatomic) NSArray *aryType;
@property (copy  , nonatomic) NSArray *aryTitle;
@property (nonatomic, strong) CBCentralManager          *centralManager;  
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self instanceSubView];


//    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];

    [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self get];
    }];
}

- (void)instanceSubView
{
    self.aryTitle= @[@"打开相册权限",
                     @"打开相机权限",
                     @"打开媒体资料库权限",
                     @"打开麦克风权限",
                     @"打开位置权限-使用期间",
                     @"打开位置权限-始终使用",
                     @"打开推送权限",
                     @"打开语音识别权限",
                     @"打开日历权限",
                     @"打开通讯录权限",
                     @"打开提醒事项权限",
                     @"打开移动网络权限",
                     @"打开健康Health权限",
                     @"打开运动与健身权限",
                     @"打开HomeKit权限"
                     ];
    self.aryType = @[@(PermissionAuthTypePhoto),
                     @(PermissionAuthTypeCamera),
                     @(PermissionAuthTypeMedia),
                     @(PermissionAuthTypeMicrophone),
                     @(PrivacyPermissionTypeLocationWhen),
                     @(PrivacyPermissionTypeLocationAlways),
                     @(PermissionAuthTypePushNotification),
                     @(PermissionAuthTypeSpeech),
                     @(PermissionAuthTypeCalendar),
                     @(PermissionAuthTypeContact),
                     @(PermissionAuthTypeReminder),
                     @(PermissionAuthTypeNetWork),
                     @(PermissionAuthTypeHealth),
                     @(PermissionAuthTypeSportsAndFitness),
                     @(PermissionAuthTypeHomeKit)
                     ];

    self.tableView.rowHeight = 55;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.aryType.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.aryTitle[row];
    return cell;
}

- (void)tableView1:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSNumber *number = self.aryType[row];
//    PrivacyPermissionType type = number.integerValue;
//    [[TKPermission shared] authorizeWithType:type completion:^(BOOL response, PrivacyPermissionAuthorizationStatus status) {
//        NSLog(@"认证状态:%ld",status);
//    }];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSNumber *number = self.aryType[row];
    PermissionAuthType type = number.integerValue;
    [[TKPermission shared] authPermissionWithType:type completion:^(BOOL isAuth) {
        if (isAuth) {
            NSLog(@"权限获取成功！");
        }else{
            NSLog(@"权限获取失败！");
        }
    }];
}




/**
 *  --  初始化成功自动调用
 *  --  必须实现的代理，用来返回创建的centralManager的状态。
 *  --  注意：必须确认当前是CBCentralManagerStatePoweredOn状态才可以调用扫描外设的方法：
 scanForPeripheralsWithServices
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            break;
        case CBCentralManagerStatePoweredOn:
        {
            NSLog(@">>>CBCentralManagerStatePoweredOn");
            // 开始扫描周围的外设。
            /*
             -- 两个参数为Nil表示默认扫描所有可见蓝牙设备。
             -- 注意：第一个参数是用来扫描有指定服务的外设。然后有些外设的服务是相同的，比如都有FFF5服务，那么都会发现；而有些外设的服务是不可见的，就会扫描不到设备。
             -- 成功扫描到外设后调用didDiscoverPeripheral
             */
            [self.centralManager scanForPeripheralsWithServices:nil options:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark 发现外设
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary*)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"Find device:%@", [peripheral name]);
//    if (![_deviceDic objectForKey:[peripheral name]]) {
//        NSLog(@"Find device:%@", [peripheral name]);
//        if (peripheral!=nil) {
//            if ([peripheral name]!=nil) {
//                if ([[peripheral name] hasPrefix:@"根据设备名过滤"]) {
//                    [_deviceDic setObject:peripheral forKey:[peripheral name]];
//                    // 停止扫描, 看需求决定要不要加
//                    //                    [_centralManager stopScan];
//                    // 将设备信息传到外面的页面(VC), 构成扫描到的设备列表
//                    if ([self.delegate respondsToSelector:@selector(dataWithBluetoothDic:)]) {
//                        [self.delegate dataWithBluetoothDic:_deviceDic];
//                    }
//                }
//            }
//        }
//    }
}


- (void)get
{
    NSURL *url = [NSURL URLWithString:@"http://www.cocoachina.com/cms/wap.php?action=article&id=24389"];
    NSURLSession *setion = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [setion dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"data:%@",data);
    }];
    [task resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
