//
//  ListViewController.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ListViewController.h"
#import "TKPermissionKit.h"



@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (copy  , nonatomic) NSArray *aryTitle;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self instanceSubView];


    [self get];


}

- (void)instanceSubView
{
    self.aryTitle= @[@"打开相册权限",
                     @"打开相机权限",
                     @"打开媒体资料库权限",
                     @"打开蓝牙权限",
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
    self.tableView.rowHeight = 55;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.aryTitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.aryTitle[row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
        {
            [TKPermissionPhoto authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"相册权限获取成功！");
                }else{
                    NSLog(@"相册权限获取失败");
                }
            }];
        }
            break;
        case 1:
        {
            [TKPermissionCamera authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"照相机权限获取成功！");
                }else{
                    NSLog(@"照相机权限获取失败");
                }
            }];
        }
            break;
        case 2:
        {
            [TKPermissionMedia authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"媒体资料库权权限获取成功！");
                }else{
                    NSLog(@"媒体资料库权权限获取失败");
                }
            }];
        }
            break;
        case 3:
        {
            [[TKPermissionBluetooth shared] authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"蓝牙权限获取成功！");
                }else{
                    NSLog(@"蓝牙权限获取失败");
                }
            }];
        }
            break;
        case 4:
        {
            [TKPermissionMicrophone authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"麦克风权限获取成功！");
                }else{
                    NSLog(@"麦克风权限获取失败");
                }
            }];
        }
            break;
        case 5:
        {
            [[TKPermissionLocationWhen shared] authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"使用应用期间权限获取成功！");
                }else{
                    NSLog(@"使用应用期间权限获取失败");
                }
            }];
        }
            break;
        case 6:
        {
            [[TKPermissionLocationAlways shared] authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"定位始终访问权限获取成功！");
                }else{
                    NSLog(@"定位始终访问权限获取失败");
                }
            }];
        }
            break;
        case 7://推送
        {
            [TKPermissionNotification authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"推送通知权限获取成功！");
                }else{
                    NSLog(@"推送通知权限获取失败");
                }
            }];
        }
            break;
        case 8:
        {
            [TKPermissionSpeech authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"语音识别权限获取成功！");
                }else{
                    NSLog(@"语音识别权限获取失败");
                }
            }];
        }
            break;
        case 9:
        {
            [TKPermissionCalendar authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"日历权限获取成功！");
                }else{
                    NSLog(@"日历权限获取失败");
                }
            }];
        }
            break;
        case 10:
        {
            [TKPermissionContacts authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"通讯录权限获取成功！");
                }else{
                    NSLog(@"通讯录权限获取失败");
                }
            }];
        }
            break;
        case 11:
        {
            [TKPermissionReminder authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"提醒事项权限获取成功！");
                }else{
                    NSLog(@"提醒事项权限获取失败");
                }
            }];
        }
            break;
        case 12://移动网络
        {
            [TKPermissionNetWork authWithAlert:YES completion:nil];
            NSLog(@"移动网络。。。");
        }
            break;

        case 13:
        {
            [[TKPermissionHealth shared] authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"HealthKit权限获取成功！");
                }else{
                    NSLog(@"HealthKit权限获取失败");
                }
            }];
        }
            break;
        case 14:
        {
            [[TKPermissionMotion shared] authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"运动与健身权限获取成功！");
                }else{
                    NSLog(@"运动与健身权限获取失败");
                }
            }];
        }
            break;
        case 15:
        {
            [[TKPermissionHome shared] authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"HomeKit权限获取成功！");
                }else{
                    NSLog(@"HomeKit权限获取失败");
                }
            }];
        }
            break;
        default:
            break;
    }
}





- (void)get
{
    NSURL *url = [NSURL URLWithString:@"http://www.cocoachina.com/cms/wap.php?action=article&id=24389"];
    NSURLSession *setion = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [setion dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"data");
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
