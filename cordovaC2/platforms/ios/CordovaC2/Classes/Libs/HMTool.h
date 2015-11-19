//
//  HMTool.h
//  GameStageIos
//
//  Created by user on 15/6/17.
//  Copyright (c) 2015年 egret. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HMTool : NSObject

+(NSString *)internetStatus ;
+(NSString*)deviceStatus;
+(UIWindow*)rootWindow;
+(UIViewController*)currentController;
+(UIImage *)cutView;

@end
