//
//  CocoShareVideo.h
//  HuaiNanVideoSDK
//
//  Created by linxiaolong on 15/9/11.
//  Copyright © 2015年 HuaiNan. All rights reserved.
//
/******
 
 CocoShareVideo 针对微信分享的独立类，不接入微信分享的开发者可删除此文件
 
 
 、
 
 
 //＊＊＊＊＊＊＊＊ios9 需要在info.plist中配置微信的URL scheme＊＊＊＊＊＊＊＊＊//
 <key>LSApplicationQueriesSchemes</key>
 <array>
 <string>weixin</string>
 <string>wechat</string>
 </array>
 
 
 //＊＊＊＊＊＊＊＊封装代理确保分享流程对接正确，请按文档流程设置＊＊＊＊＊＊＊＊＊//
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 
//#import "WXApi.h"
@interface CocoShareVideo : NSObject{
}
@property(nonatomic, assign) id delegate;
+(CocoShareVideo*)cocoShareVideoInstance;

/**
 * (必须)
 * 参数
   delegate：代理，由于分享涉及到结算，需要正确的微信反馈数据，所以对微信代理做了封装，
   shareblock：分享是否成功，可根据值的YES or NO 给用户进行奖励等操作
 * 注： 同一个游戏只有在第一次分享成功才返回yes, sdk只结算一次
 */
+(void)cBHNWeixinDelegate:(id)delegate cBHNWXShareBlock:(void(^)(BOOL isShare))shareblock;

//分享测试方法，上线的应用不可以调用本方法
-(void)testShare;

/**
 * (可选)
 * 本方法用来区分微信分享是否来自SDK
 * 参数 
   ynNoSdk: YES为开发者自己写的微信分享／NO为SDK内置的分享
 * 用法： 开发者每次调用自己的微信分享之前需同时调用本方法 [CocoShareVideo cBShareNOSDK:YES];
 */
-(void)cBShareNOSDK:(BOOL)ynNoSdk;
@end
