#import "GoogleAnalyticsPlugin.h"
// Dispatch period in seconds
static const NSInteger kGANDispatchPeriodSec = 2;
@implementation GoogleAnalyticsPlugin

//- (void) startTracker:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options {
- (void) startTracker:(CDVInvokedUrlCommand*)command
{
    //get the callback id
    
    NSMutableDictionary* options=[command.arguments objectAtIndex:0];
    NSString *accountId = [options valueForKey:@"accountId"];
    CDVPluginResult* pluginResult = nil;
    NSLog(@"Starting analytics with account: %@",accountId);
    [GAI sharedInstance].debug = YES;
    [GAI sharedInstance].dispatchInterval = kGANDispatchPeriodSec;
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    if ( [[GAI sharedInstance] trackerWithTrackingId:accountId] ) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Success :)"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"Error :("];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//- (void) trackView:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
- (void) trackView:(CDVInvokedUrlCommand*)command
{
    
    NSMutableDictionary* options=[command.arguments objectAtIndex:0];
    NSString *screen = [options valueForKey:@"screen"];
    CDVPluginResult* pluginResult = nil;
    
    NSLog(@"Tracking View:: %@",screen);
    if ( [[GAI sharedInstance].defaultTracker sendView:screen]){
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Success :)"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"Error :("];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
//- (void) setCustomDimension:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
- (void) setCustomDimension:(CDVInvokedUrlCommand*)command
{
    NSMutableDictionary* options=[command.arguments objectAtIndex:0];
    //NSString *callbackId = [arguments pop];
    NSNumber *index = [options valueForKey:@"index"];
    NSString *value = [options valueForKey:@"value"];
    CDVPluginResult* pluginResult = nil;
    if(value.length>0){
        NSLog(@"Set Custom Dimension %@ at index %@",value,index);
        if ( [[GAI sharedInstance].defaultTracker setCustom:[index integerValue]
                                                  dimension:value ] ) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Success :)"];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"Error :("];
        }
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
    
}

- (void) trackEvent:(CDVInvokedUrlCommand*)command
{
    
    NSMutableDictionary* options=[command.arguments objectAtIndex:0];
    NSString* category = [options valueForKey:@"category"];
    NSString* action = [options valueForKey:@"action"];
    NSString* label = [options valueForKey:@"label"];
    NSNumber* value = [options valueForKey:@"value"];
    NSLog(@"Tracking Event::%@, %@, %@, %@",category,action,label,value);
    CDVPluginResult* pluginResult = nil;
    
    if ( [[GAI sharedInstance].defaultTracker sendEventWithCategory:category
                                                         withAction:action
                                                          withLabel:label
                                                          withValue:value]) {
        NSLog(@"GoogleAnalyticsPlugin.trackEvent::%@, %@, %@, %@",category,action,label,value);
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Success :)"];
    } else {
        NSLog(@"GoogleAnalyticsPlugin.trackView Error::");
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"Error :("];
        
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

//- (void) trackTiming:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
- (void) trackTiming:(CDVInvokedUrlCommand*)command
{
    //NSString *callbackId = [arguments pop];
    //NSLog(@"Tracking Timing");
    NSMutableDictionary* options=[command.arguments objectAtIndex:0];
    NSString* category = [options valueForKey:@"category"];
    NSString* time = [options valueForKey:@"time"];
    NSString* name = [options valueForKey:@"name"];
    NSString* label = [options valueForKey:@"label"];
    NSTimeInterval nstime=[time doubleValue];
    CDVPluginResult* pluginResult = nil;
    if ( [[GAI sharedInstance].defaultTracker sendTimingWithCategory:category
                                                           withValue:nstime
                                                            withName:name
                                                           withLabel:label]) {
        NSLog(@"GoogleAnalyticsPlugin.trackTiming::%@, %f, %@, %@",category,nstime,name,label);
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Success :)"];
    } else {
        NSLog(@"GoogleAnalyticsPlugin.trackView Error::");
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"Error :("];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void) hitDispatched:(NSString *)hitString
{
    NSString* callback = [NSString stringWithFormat:@"window.plugins.googleAnalyticsPlugin.hitDispatched(%@);",  hitString];
    [ self.webView stringByEvaluatingJavaScriptFromString:callback];
}
@end