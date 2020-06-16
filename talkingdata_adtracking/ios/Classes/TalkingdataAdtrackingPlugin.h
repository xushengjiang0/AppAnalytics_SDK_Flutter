#import <Flutter/Flutter.h>

@interface TalkingdataAdtrackingPlugin : NSObject<FlutterPlugin>
+(void)pluginSessionStart:(NSString*)session withChannelId:(NSString*)channelID;
@end
