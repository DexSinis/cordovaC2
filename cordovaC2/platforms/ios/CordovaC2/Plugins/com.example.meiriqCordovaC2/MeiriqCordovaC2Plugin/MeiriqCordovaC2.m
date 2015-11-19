#import "MeiriqCordovaC2.h"

@implementation MeiriqCordovaC2

- (void)greet:(CDVInvokedUrlCommand*)command
{
    
    NSString* callbackId = [command callbackId];
    NSString* commands = [[command arguments] objectAtIndex:0];
    NSArray * arr = [commands componentsSeparatedByString:@","];
    NSLog(@"commands---%@",commands);
    if ([arr[0] isEqualToString:@"over"]) {
        //        NSLog(name);
        //        MainViewController *viewController = [MainViewController sharedMainViewController];
//        [HMNotificationCenter postNotificationName:PlayVedioNotification object:nil userInfo:nil];
        //        if ([viewController.interstitial isReady]){
        //            [viewController.interstitial showFromViewController:viewController];
        //        }
      [HMNotificationCenter postNotificationName:PlayVedioNotification object:nil userInfo:@{@"isVideo":@""}];
        
    }
    if ([arr[0] isEqualToString:@"showad"]) {
        //        NSLog(name);
        //        MainViewController *viewController = [MainViewController sharedMainViewController];
        [HMNotificationCenter postNotificationName:PlayVedioNotification object:nil userInfo:@{@"isVideo":@""}];
        //        if ([viewController.interstitial isReady]){
        //            [viewController.interstitial showFromViewController:viewController];
        //        }
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeNameNotification" object:self userInfo:@{@"name":@"dexsinis"}];
    }
    
    //    else if([name isEqualToString:@"veido"])
    //    {
    //         [HMNotificationCenter postNotificationName:VerifyPurchaseWithPaymentTransactionNotification object:nil userInfo:nil];
    //    }else
    //    {
    //
    //    }
    //    NSString* msg = [NSString stringWithFormat: @"Hello, %@", name];
    //
    //    CDVPluginResult* result = [CDVPluginResult
    //                               resultWithStatus:CDVCommandStatus_OK
    //                               messageAsString:msg];
    ////
    ////    [self success:result callbackId:callbackId];
    //    
    //    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

@end
