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

#import <Cordova/CDVViewController.h>
#import <Cordova/CDVCommandDelegateImpl.h>
#import <Cordova/CDVCommandQueue.h>


#import <UIKit/UIKit.h>
#import "IMInterstitial.h"
#import "IMInterstitialDelegate.h"
#import "IMNative.h"
#import "HMSingleton.h"
#import "GDTMobInterstitial.h"
#import "GDTMobBannerView.h"

@interface MainViewController : CDVViewController

@property (nonatomic,strong) IMInterstitial *interstitial;
@property (nonatomic,strong) GDTMobBannerView *banner;
@property (nonatomic,strong) GDTMobInterstitial *interstitialObj;
//@property (nonatomic,strong) IMInterstitial *rewardedAd;

@property (copy,nonatomic)  NSString *clickSignal;
HMSingletonH(MainViewController)

- (void)showAd:(id)sender;
- (void)loadAd:(id)sender;
@end

@interface MainCommandDelegate : CDVCommandDelegateImpl
@end

@interface MainCommandQueue : CDVCommandQueue
@end
