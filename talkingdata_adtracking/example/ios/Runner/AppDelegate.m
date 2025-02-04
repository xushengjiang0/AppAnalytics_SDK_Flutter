#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <talkingdata_adtracking/TalkingdataAdtrackingPlugin.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
    [TalkingdataAdtrackingPlugin pluginSessionStart:@"1" withChannelId:@"2"];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
