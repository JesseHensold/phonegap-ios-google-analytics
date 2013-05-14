#import <Foundation/Foundation.h>
#import "GAI.h"
#import <Cordova/CDV.h>
@interface GoogleAnalyticsPlugin : CDVPlugin  {
}

- (void) startTracker:(CDVInvokedUrlCommand*)command;

- (void) trackView:(CDVInvokedUrlCommand*)command;

- (void) trackEvent:(CDVInvokedUrlCommand*)command;

- (void) trackTiming:(CDVInvokedUrlCommand*)command;

- (void) setCustomDimension:(CDVInvokedUrlCommand*)command;

@end