/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  MainViewController.h
//  CordovaC2
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "MainViewController.h"
#import "GDTMobBannerView.h" 

#import "CocoBVideo.h"
#import "HMTool.h"
//#define INMOBI_BANNER           1435588185902  //横幅ID（暂时不改）
//#define INMOBI_INTERSTITIAL     1435922107981

@interface MainViewController () <IMInterstitialDelegate,GDTMobInterstitialDelegate,GDTMobBannerViewDelegate> //Replace UIViewController with your controller


@end
@implementation MainViewController
static NSString *INTERSTITIAL_STATE_TEXT = @"插屏状态";
HMSingletonM(MainViewController);
- (BOOL)prefersStatusBarHidden
{
    return YES; // 返回NO表示要显示，返回YES将hiden
}
-(void)viewDidAppear:(BOOL)animated
{
    float adViewHeight = 50.0;
    // Do any additional setup after loading the view, typically from a nib.
//    self.banner = [[IMBanner alloc] initWithFrame:CGRectMake((self.view.frame.size.width-320)/2, self.view.frame.size.height-adViewHeight, 320, 50.0) placementId:INMOBI_BANNER delegate:self];
     self.banner = [[GDTMobBannerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-320)/2, self.view.frame.size.height-adViewHeight,GDTMOB_AD_SUGGEST_SIZE_320x50.width,GDTMOB_AD_SUGGEST_SIZE_320x50.height)
                                                   appkey:GDTAPPIDBANNER
                                              placementId:GDTPIDBANNER];
    
    
    self.banner.delegate = self; // 设置Delegate
    self.banner.currentViewController = self; //设置当前的ViewController
    self.banner.interval = 30; //【可选】设置刷新频率;默认30秒
    self.banner.isGpsOn = NO; //【可选】开启GPS定位;默认关闭
    self.banner.showCloseBtn = YES; //【可选】展示关闭按钮;默认显示
    self.banner.isAnimationOn = YES; //【可选】开启banner轮播和展现时的动画效果;默认开启
    [self.view addSubview:self.banner]; //添加到当前的view中
    [self.banner loadAdAndShow]; //加载广告并展示
    
    
    self.interstitial = [[IMInterstitial alloc] initWithPlacementId:INMOBI_INTERSTITIAL delegate:self];
//    [self.interstitial load];
    
    [self loadAd:nil];

}

-(void)adShow:(NSNotification*)notification
{
    NSDictionary *dict = [notification userInfo];
    
    NSString *isVideo = dict[@"isVideo"];
    NSLog(@"%@--------------------",isVideo);
    if ([isVideo isEqualToString:@"video"]) {
        [CocoBVideo cBIsHaveVideo:^(int isHaveVideoStatue) {
            
            
            if (isHaveVideoStatue == 0) {
                
                [CocoBVideo cBVideoPlay:[HMTool currentController] cBVideoPlayFinishCallBackBlock:^(BOOL isFinishPlay){
                    NSLog(@"视频播放结束");
                } cBVideoPlayConfigCallBackBlock:^(BOOL isLegal){
                    NSLog(@"此次播放是否有效：%d",isLegal);
                    if(isLegal){
                        [self.webView stringByEvaluatingJavaScriptFromString:@"meiriq.CommonComponent.excuteHook('adsuccess')"];
                    }
                }];
                return ;
            }
            else
            {
                //                        ExternalInterface::call("gameInterface", "resetOfVedioNotOK");
                return;
            }
            
        }];
    }
    else if([self.interstitialObj isReady])
    {
        [self showAd:nil];
    }
    else if ([self.interstitial isReady]){
        [self.interstitial showFromViewController:self];
    }
    else{
        [self.webView stringByEvaluatingJavaScriptFromString:@"meiriq.CommonComponent.excuteHook('playvediofailure')"];
    }
    

    
    
//
    
}

#pragma mark － 弹窗通知处理


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return YES;
}




#pragma mark --IMInterstitialDelegate


- (void)interstitial:(IMInterstitial *)interstitial didFailToLoadWithError:(IMRequestStatus *)error{
    NSLog(@"Interstitial Failed to load interstitial with error: %@",error.description);
    double delayInSeconds = 20.0;
    
    dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    // 得到全局队列
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 延期执行
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
        [self.interstitial load];
    });
}
- (void)interstitial:(IMInterstitial *)interstitial didFailToPresentWithError:(IMRequestStatus *)error {
    NSLog(@"Interstitial Failed to Present Interstitial with error : %@",error.description);
}
- (void)interstitial:(IMInterstitial *)interstitial didInteractWithParams:(NSDictionary *)params {
    NSLog(@"Interstitial did interact with param : %@",params);
    self.clickSignal = @"click";
}
- (void)interstitial:(IMInterstitial *)interstitial rewardActionCompletedWithRewards:(NSDictionary *)rewards {
    NSLog(@"Interstitial reward action completed with Rewards : %@",rewards);
}
- (void)interstitialDidDismiss:(IMInterstitial *)interstitial {
    NSLog(@"Interstitial Did Dismiss");
//    NSLog(@"%@",self.webView);
//    [self.webView stringByEvaluatingJavaScriptFromString:@"alert(1)"];
   
    [self.interstitial load];
}
- (void)interstitialDidFinishLoading:(IMInterstitial *)interstitial {
    NSLog(@"Interstitial Did Finish Loading");
}
- (void)interstitialDidPresent:(IMInterstitial *)interstitial {
    
    //    HWPHello *hello = [[HWPHello alloc] init];
    //
    //    CDVPluginResult*result = [CDVPluginResult
    //                               resultWithStatus:CDVCommandStatus_OK
    //                               messageAsString:@"1111"];
    //
    //    [hello.commandDelegate sendPluginResult:result callbackId:@"111"];
    //    NSLog(@"Interstitial Did Present");
    
}
- (void)interstitialWillDismiss:(IMInterstitial *)interstitial {
    NSLog(@"Interstitial Will Dismiss");
    if ([self.clickSignal isEqualToString:@"click"]) {
        [self.webView stringByEvaluatingJavaScriptFromString:@"meiriq.CommonComponent.excuteHook('adsuccess')"];
        self.clickSignal = nil;
    }
//    [self.webView stringByEvaluatingJavaScriptFromString:@"meiriq.CommonComponent.excuteHook('adsuccess')"];
    
}
- (void)interstitialWillPresent:(IMInterstitial *)interstitial {
    NSLog(@"Interstitial Will Present");
}


//#pragma mark --IMInterstitialDelegate --rewardedAd
//
////- (void)interstitial:(IMInterstitial *)rewardedAd didFailToLoadWithError:(IMRequestStatus *)error{
////    NSLog(@"Rewarded Ad Failed to load with error: %@",error.description);
////}
////- (void)interstitial:(IMInterstitial *)rewardedAd didFailToPresentWithError:(IMRequestStatus *)error {
////    NSLog(@"Rewarded Ad Failed to Present with error : %@",error.description);
////}
////- (void)interstitial:(IMInterstitial *)rewardedAd didInteractWithParams:(NSDictionary *)params {
////    NSLog(@"Rewarded Ad did interact with param : %@",params);
////}
////- (void)interstitial:(IMInterstitial *)rewardedAd rewardActionCompletedWithRewards:(NSDictionary *)rewards {
////
////    //Write code here to parse the rewards that you have set up and pass it on to the user.
////    NSLog(@"Rewarded Ad action completed with Rewards : %@",rewards);
////}
////- (void)interstitialDidDismiss:(IMInterstitial *)rewardedAd {
////    NSLog(@"Rewarded Ad Did Dismiss");
////}
////- (void)interstitialDidFinishLoading:(IMInterstitial *)rewardedAd {
////    NSLog(@"Rewarded Ad Did Finish Loading");
////
////}
////- (void)interstitialDidPresent:(IMInterstitial *)rewardedAd {
////    NSLog(@"Rewarded Ad Did Present");
////}
////- (void)interstitialWillDismiss:(IMInterstitial *)rewardedAd {
////    NSLog(@"Rewarded Ad Will Dismiss");
////}
////- (void)interstitialWillPresent:(IMInterstitial *)rewardedAd {
////    NSLog(@"Rewarded Ad Will Present");
////}

/**
 *  在适当的时候，初始化并调用loadAd方法进行预加载
 */
- (void)loadAd:(id)sender {
     _interstitialObj = [[GDTMobInterstitial alloc] initWithAppkey:GDTAPPID placementId:GDTPID];
    _interstitialObj.delegate = self; //设置委托
    _interstitialObj.isGpsOn = NO; //【可选】设置GPS开关
    //预加载广告
    [_interstitialObj loadAd];
}

/**
 *  在适当的时候，调用presentFromRootViewController来展现插屏广告
 */
- (void)showAd:(id)sender {
    UIViewController *vc = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [_interstitialObj presentFromRootViewController:vc];
}

/**
 *  广告预加载成功回调
 *  详解:当接收服务器返回的广告数据成功后调用该函数
 */
- (void)interstitialSuccessToLoadAd:(GDTMobInterstitial *)interstitial
{
    NSLog(@"%@:%@",INTERSTITIAL_STATE_TEXT,@"Success Loaded.");
}

/**
 *  广告预加载失败回调
 *  详解:当接收服务器返回的广告数据失败后调用该函数
 */
- (void)interstitialFailToLoadAd:(GDTMobInterstitial *)interstitial error:(NSError *)error
{
    
    NSLog(@"%@:%@---%@",INTERSTITIAL_STATE_TEXT,@"Fail Loaded.",error);
    [self loadAd:nil];
}

/**
 *  插屏广告将要展示回调
 *  详解: 插屏广告即将展示回调该函数
 */
- (void)interstitialWillPresentScreen:(GDTMobInterstitial *)interstitial
{
    NSLog(@"%@:%@",INTERSTITIAL_STATE_TEXT,@"Going to present.");
}

/**
 *  插屏广告视图展示成功回调
 *  详解: 插屏广告展示成功回调该函数
 */
- (void)interstitialDidPresentScreen:(GDTMobInterstitial *)interstitial
{
    NSLog(@"%@:%@",INTERSTITIAL_STATE_TEXT,@"Success Presented." );
}

/**
 *  插屏广告展示结束回调
 *  详解: 插屏广告展示结束回调该函数
 */
- (void)interstitialDidDismissScreen:(GDTMobInterstitial *)interstitial
{
    NSLog(@"%@:%@",INTERSTITIAL_STATE_TEXT,@"Finish Presented.");
//    self.clickSignal = nil;
//    NSString *script = [NSString stringWithFormat:@"meiriq.CommonComponent.excuteHook('%@')",self.clickSignal];
    if ([self.clickSignal isEqualToString:@"click"]) {
         [self.webView stringByEvaluatingJavaScriptFromString:@"meiriq.CommonComponent.excuteHook('adsuccess')"];
        self.clickSignal = nil;
   }
 //       else
//    {
//        self.clickSignal = nil;
//    }
//   
    [self loadAd:nil];
}

/**
 *  应用进入后台时回调
 *  详解: 当点击下载应用时会调用系统程序打开，应用切换到后台
 */
- (void)interstitialApplicationWillEnterBackground:(GDTMobInterstitial *)interstitial
{
    NSLog(@"%@:%@",INTERSTITIAL_STATE_TEXT,@"Application enter background.");
}

/**
 *  插屏广告曝光时回调
 *  详解: 插屏广告曝光时回调
 */
-(void)interstitialWillExposure:(GDTMobInterstitial *)interstitial
{
    NSLog(@"%@:%@",INTERSTITIAL_STATE_TEXT,@"Exposured");
}
/**
 *  插屏广告点击时回调
 *  详解: 插屏广告点击时回调
 */
-(void)interstitialClicked:(GDTMobInterstitial *)interstitial
{
    self.clickSignal = @"click";
    NSLog(@"%@:%@",INTERSTITIAL_STATE_TEXT,@"Clicked");
}


#pragma GDTBanner

- (void) viewWillDisappear:(BOOL)animated
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)bannerViewMemoryWarning
{
    NSLog(@"%s",__FUNCTION__);
}

// 请求广告条数据成功后调用
//
// 详解:当接收服务器返回的广告数据成功后调用该函数
- (void)bannerViewDidReceived
{
    NSLog(@"%s",__FUNCTION__);
}

// 请求广告条数据失败后调用
//
// 详解:当接收服务器返回的广告数据失败后调用该函数
- (void)bannerViewFailToReceived:(NSError *)error
{
    NSLog(@"%s, Error:%@",__FUNCTION__,error);
}

// 应用进入后台时调用
//
// 详解:当点击下载或者地图类型广告时，会调用系统程序打开，
// 应用将被自动切换到后台
- (void)bannerViewWillLeaveApplication
{
    NSLog(@"%s",__FUNCTION__);
}

// banner条曝光回调
//
// 详解:banner条曝光时回调该方法
- (void)bannerViewWillExposure
{
    NSLog(@"%s",__FUNCTION__);
}

// banner条点击回调
//
// 详解:banner条被点击时回调该方法
- (void)bannerViewClicked
{
    NSLog(@"%s",__FUNCTION__);
}

/**
 *  banner条被用户关闭时调用
 *  详解:当打开showCloseBtn开关时，用户有可能点击关闭按钮从而把广告条关闭
 */
- (void)bannerViewWillClose
{
    NSLog(@"%s",__FUNCTION__);
}



- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}


#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    // View defaults to full size.  If you want to customize the view's size, or its subviews (e.g. webView),
    // you can do so here.
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    HMAddObsver(show:, PlayVedioNotification);
//    NSDictionary *dict = @{@"isVideo":@"vedio"};
    [HMNotificationCenter addObserver:self selector:@selector(adShow:) name:PlayVedioNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeNameNotification:) name:@"ChangeNameNotification" object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:PlayVedioNotification　object:@"video"];
    // Do any additional setup after loading the view from its nib.
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

/* Comment out the block below to over-ride */

/*
 - (UIWebView*) newCordovaViewWithFrame:(CGRect)bounds
 {
 return[super newCordovaViewWithFrame:bounds];
 }
 */

#pragma mark UIWebDelegate implementation

- (void)webViewDidFinishLoad:(UIWebView*)theWebView
{
    // Black base color for background matches the native apps
    theWebView.backgroundColor = [UIColor blackColor];
    
    return [super webViewDidFinishLoad:theWebView];
}

/* Comment out the block below to over-ride */

/*
 
 - (void) webViewDidStartLoad:(UIWebView*)theWebView
 {
 return [super webViewDidStartLoad:theWebView];
 }
 
 - (void) webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error
 {
 return [super webView:theWebView didFailLoadWithError:error];
 }
 
 - (BOOL) webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
 {
 return [super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType];
 }
 */

@end

@implementation MainCommandDelegate

/* To override the methods, uncomment the line in the init function(s)
 in MainViewController.m
 */

#pragma mark CDVCommandDelegate implementation

- (id)getCommandInstance:(NSString*)className
{
    return [super getCommandInstance:className];
}

- (NSString*)pathForResource:(NSString*)resourcepath
{
    return [super pathForResource:resourcepath];
}

@end

@implementation MainCommandQueue

/* To override, uncomment the line in the init function(s)
 in MainViewController.m
 */
- (BOOL)execute:(CDVInvokedUrlCommand*)command
{
    return [super execute:command];
}


@end
