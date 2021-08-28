//
//  ListViewController.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/8/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ListViewController.h"
#import "TKPermissionKit.h"
#import <CoreLocation/CoreLocation.h>





@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (copy  , nonatomic) NSArray *aryTitle;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"TKPermissionKit";
    [self instanceSubView];


    [self get];

    self.automaticallyAdjustsScrollViewInsets = NO;

}

- (void)instanceSubView
{
    self.aryTitle= @[@"请求相册权限",
                     @"请求相机权限",
                     @"请求媒体资料库权限",
                     @"请求蓝牙权限 ",
                     @"请求麦克风权限",
                     @"请求位置权限-使用期间 ",
                     @"请求位置权限-始终使用 ",
                     @"请求推送权限",
                     @"请求语音识别权限 ",
                     @"请求日历权限",
                     @"请求通讯录权限 ",
                     @"请求提醒事项权限",
                     @"请求移动网络权限      ⚠️ 没有作用 \n 可以使用ZYNetworkAccessibility检测",
                     @"请求健康Health权限 \n⚠️:只能检测\"写入数据\"类别中的type",
                     @"请求运动与健身权限 ",
                     @"请求HomeKit权限    ",
                     @"请求文件与文件夹",
                     @"请求AppTrackingTransparency权限",
                     @"请求Siri权限 （需要打开添加Siri开关）"
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
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 2;
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
                [self testAddView];
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
                [self testAddView];
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
                [self testAddView];
            }];
        }
            break;
        case 3:
        {
            [TKPermissionBluetooth authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"蓝牙权限获取成功！");
                }else{
                    NSLog(@"蓝牙权限获取失败");
                }
                NSLog(@"isAuth:%d",[TKPermissionBluetooth checkAuth]);
                [self testAddView];
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
                [self testAddView];
            }];
        }
            break;
        case 5:
        {
            [TKPermissionLocationWhen authWithAlert:YES completion:^(BOOL isAuth) {

                    if (isAuth) {
                        NSLog(@"使用<<应用期间>>权限获取成功！");
                    }else{
                        NSLog(@"使用<<应用期间>>权限获取失败");
                    }
                    [self testAddView];
            }];
        }
            break;
        case 6:
        {
            [TKPermissionLocationAlways authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"定位<<始终访问>>权限获取成功！");
                }else{
                    NSLog(@"定位<<始终访问>>权限获取失败");
                }
                [self testAddView];
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
                [self testAddView];
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
                [self testAddView];
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
                [self testAddView];
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
                [self testAddView];
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
                [self testAddView];
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
            [TKPermissionHealth  authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"HealthKit权限获取成功！");

                }else{
                    NSLog(@"HealthKit权限获取失败");
                }
                [self testAddView];
            }];
        }
            break;
        case 14:
        {
            [TKPermissionMotion authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"运动与健身权限获取成功！");
                }else{
                    NSLog(@"运动与健身权限获取失败");
                }
                [self testAddView];
            }];
        }
            break;
        case 15:
        {
            [TKPermissionHome  authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"HomeKit权限获取成功！");
                }else{
                    NSLog(@"HomeKit权限获取失败");
                }
                [self testAddView];
            }];
        }
            break;
            case 16:
        {
            [TKPermissionFolders authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"请求文件与文件夹成功！");
                }else{
                    NSLog(@"请求文件与文件夹失败");
                }
                [self testAddView];
            }];
        }
        case 17:
        {
            [TKPermissionTracking authWithCompletion:^(BOOL isAuth, NSString * _Nonnull idfa) {
                if (isAuth) {
                    NSLog(@"请求AppTrackingTransparency成功！");
                }else{
                    NSLog(@"请求AppTrackingTransparency失败");
                }
                NSLog(@"isAuth:%d  idaf:%@",isAuth,idfa);
            }];
        }
            break;
        case 18:
        {
            [TKPermissionSiri authWithAlert:YES completion:^(BOOL isAuth) {
                if (isAuth) {
                    NSLog(@"请求Siri成功！");
                }else{
                    NSLog(@"请求Siri失败");
                }
            }];;
        }
            break;;
        default:
            break;
    }
}





- (void)get
{
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLSession *setion = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [setion dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"test networing data");
    }];
    [task resume];
}

- (void)testAddView
{
    UIView  *vi = [[UIView alloc] init];
    vi.frame = CGRectMake(0, 0, 100, 100);
    vi.backgroundColor = UIColor.purpleColor;
    [self.view addSubview:vi];
    [UIView animateWithDuration:1.0 animations:^{
        vi.frame = CGRectMake(280, 64, 100, 100);
    }];
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
