
//  HMTool.m
//  GameStageIos
//
//  Created by user on 15/6/17.
//  Copyright (c) 2015年 egret. All rights reserved.
//

#import "HMTool.h"
#import "sys/utsname.h"

@implementation HMTool


#pragma mark - 获取网络状态
+(NSString *)internetStatus {
    
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"wifi";
    
    switch (type) {
        case 0:
            stateString = @"notReachable";
            break;
            
        case 1:
            stateString = @"2G";
            break;
            
        case 2:
            stateString = @"3G";
            break;
            
        case 3:
            stateString = @"4G";
            break;
            
        case 4:
            stateString = @"LTE";
            break;
            
        case 5:
            stateString = @"wifi";
            break;
            
        default:
            break;
    }
    
    return stateString;
}

+(NSString*)deviceStatus
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return
        @"640,960";
    //@"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return
        @"640,960";
    //@"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return
        @"640,960";
    //@"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return
        @"640,960";
    //@"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return
        @"640,960";
    //@"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return
        @"640,960";
    //@"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return
        @"640,960";
    //@"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return
        @"640,1136";
    //@"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return
        @"640,1136";
    //@"640,1136"@"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return
        @"640,1136";
    //@"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return
        @"640,1136";
    //@"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return
        @"640,1136";
    // @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return
        @"640,1136";
    //@"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return
        @"1242,2208";
    //@"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return
        @"750,1334";
    //@"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPod1,1"]) return
        @"640,960";
    //@"iPodTouch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"]) return
        @"640,960";
    //@"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"]) return
        @"640,960";
    //@"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"]) return
        @"640,960";
    //@"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"]) return
        @"640,1136";
    //@"iPod Touch 5G (A1421/A1509)";
    if ([platform isEqualToString:@"iPad1,1"]) return
        @"768,1024";
    //@"iPad 1G (A1219/A1337)";
    if ([platform isEqualToString:@"iPad2,1"]) return
        @"768,1024";
    //@"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"]) return
        @"768,1024";
    //@"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"]) return
        @"768,1024";
    //@"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"]) return
        @"768,1024";
    //@"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"]) return
        @"768,1024";
    //@"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"]) return
        @"768,1024";
    //@"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"]) return
        @"768,1024";
    // @"iPad Mini 1G (A1455)";
    if ([platform isEqualToString:@"iPad3,1"]) return
        @"1536,2048";
    // @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"]) return
        @"1536,2048";
    //@"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"]) return
        @"1536,2048";
    //@"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"]) return
        @"1536,2048";
    // @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"]) return
        @"1536,2048";
    //@"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"]) return
        @"1536,2048";
    //@"iPad 4 (A1460)";
    if ([platform isEqualToString:@"iPad4,1"]) return
        @"1536,2048";
    //@"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"]) return
        @"1536,2048";
    //@"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"]) return
        @"1536,2048";;
    //@"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"]) return
        @"1536,2048";
    //@"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"]) return
        @"1536,2048";
    //@"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"]) return
        @"1536,2048";
    //@"iPad Mini 2G (A1491)";
    //    if ([platform isEqualToString:@"i386"]) return
    //        //@"5.5";
    //        @"640,1136";
    //    //@"iPhone Simulator";
    //    if ([platform isEqualToString:@"x86_64"])
    //        return @"750,1334";
    
    
    NSLog(@"%f",[UIScreen mainScreen].scale);
    NSLog(@"%f",[[UIScreen mainScreen] bounds].size.height);
    NSLog(@"%f",[[UIScreen mainScreen] bounds].size.width);
    
    if (([[UIScreen mainScreen] bounds].size.height == 480)) {
        return @"640,960";
    }
    else if ((568 == [[UIScreen mainScreen] bounds].size.height))
    {
        return @"640,1136";
    }else if ((667 == [[UIScreen mainScreen] bounds].size.height))
    {
        return  @"750,1334";
    }else if ((736 == [[UIScreen mainScreen] bounds].size.height))
    {
        return @"1242,2208";
    }else if ((1024 == [[UIScreen mainScreen] bounds].size.height)&&([UIScreen mainScreen].scale == 1))
    {
        return @"768,1024";
    }else if((1024 == [[UIScreen mainScreen] bounds].size.height)&&([UIScreen mainScreen].scale==2))
    {
        return @"1536,2048";
    }
    
    return @"640,1136";
}

+(UIWindow*)rootWindow
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    return window;
}

+(UIViewController*)currentController
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    
    return result;
}

+(UIImage *)cutView
{
    UIViewController *result = [HMTool currentController];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth(result.view.frame),CGRectGetHeight(result.view.frame)), YES,0);
    [result.view
     drawViewHierarchyInRect:CGRectMake(0,0,CGRectGetWidth(result.view.frame), CGRectGetHeight(result.view.frame))
     afterScreenUpdates:NO];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    return snapshot;
    
}

-(void)delay
{
    double delayInSeconds = 1.0;
    
    dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    // 得到全局队列
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 延期执行
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
        
    });
    
    [NSThread sleepForTimeInterval:0.01f];
}




@end
