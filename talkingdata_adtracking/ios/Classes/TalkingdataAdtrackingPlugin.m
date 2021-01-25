#import "TalkingdataAdtrackingPlugin.h"
#import "TalkingDataAppCpa.h"

@implementation TalkingdataAdtrackingPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"talkingdata_adtracking"
            binaryMessenger:[registrar messenger]];
  TalkingdataAdtrackingPlugin* instance = [[TalkingdataAdtrackingPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

+(void)pluginSessionStart:(NSString*)session withChannelId:(NSString*)channelID
{
    [TalkingDataAppCpa init:session withChannelId:channelID];
}

-(id)checkArgument:(NSDictionary*)argument forKey:(NSString*)key ofType:(Class)clazz
{
    if (key == nil || argument == nil || clazz == nil  ) {
        return nil;
    }
    id arg = [argument objectForKey:key];
    if (arg == nil) {
        return nil;
    }
    if (![arg isKindOfClass:clazz]) {
        return nil;
    }
    return arg;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"onPageStart" isEqualToString:call.method]) {
        NSLog(@"pageStart");
    }else if ([@"onRegister" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        if (profile) {
            [TalkingDataAppCpa onRegister:profile];
        }
    }else if([@"onRegisterWithInvitationCode" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * invitationCode = [self checkArgument:call.arguments forKey:@"invitationCode" ofType:[NSString class]];
        if (profile && invitationCode) {
            [TalkingDataAppCpa onRegister:profile invitationCode:invitationCode];
        }

    }else if([@"onLogin" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        if (profile) {
            [TalkingDataAppCpa onLogin:profile];
        }
    }else if([@"onCreateCard" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * method = [self checkArgument:call.arguments forKey:@"method" ofType:[NSString class]];
        NSString * content = [self checkArgument:call.arguments forKey:@"content" ofType:[NSString class]];
        if (profile && method && content) {
            [TalkingDataAppCpa onCreateCard:profile method:method content:content];
        }

    }else if([@"onReceiveDeepLink" isEqualToString:call.method]){
        NSString * link = [self checkArgument:call.arguments forKey:@"link" ofType:[NSString class]];
        if (link) {
            [TalkingDataAppCpa onReceiveDeepLink:[NSURL URLWithString:link]];
        }
    }else if([@"onFavorite" isEqualToString:call.method]){
        NSString * category = [self checkArgument:call.arguments forKey:@"category" ofType:[NSString class]];
        NSString * content = [self checkArgument:call.arguments forKey:@"content" ofType:[NSString class]];
        if (category && content) {
            [TalkingDataAppCpa onFavorite:category content:content];
        }
    }else if([@"onShare" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * content = [self checkArgument:call.arguments forKey:@"content" ofType:[NSString class]];
        if (profile && content) {
            [TalkingDataAppCpa onShare:profile content:content];
        }
    }else if([@"onPunch" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * punchId = [self checkArgument:call.arguments forKey:@"punchId" ofType:[NSString class]];
        if (profile && punchId) {
            [TalkingDataAppCpa onPunch:profile punchId:punchId];
        }
    }else if([@"onSearch" isEqualToString:call.method]){
        NSString * category = [self checkArgument:call.arguments forKey:@"category" ofType:[NSString class]];
        NSString * content = [self checkArgument:call.arguments forKey:@"content" ofType:[NSString class]];
        NSArray * itemId = [self checkArgument:call.arguments forKey:@"itemId" ofType:[NSString class]];
        NSArray * itemLocationId = [self checkArgument:call.arguments forKey:@"itemLocationId" ofType:[NSString class]];
        NSString * destination = [self checkArgument:call.arguments forKey:@"destination" ofType:[NSString class]];
        NSString * origin = [self checkArgument:call.arguments forKey:@"origin" ofType:[NSString class]];
        NSNumber * startDate = [self checkArgument:call.arguments forKey:@"startDate" ofType:[NSNumber class]];
        NSNumber * endDate = [self checkArgument:call.arguments forKey:@"endDate" ofType:[NSNumber class]];
        TDSearch * search = [[TDSearch alloc]init];
        search.category = category;
        search.content = content;
        search.itemId = itemId;
        search.itemLocationId = itemLocationId;
        search.destination = destination;
        search.origin = origin;
        search.startDate = startDate.longLongValue;
        search.endDate = endDate.longLongValue;
        [TalkingDataAppCpa onSearch:search];
    }else if([@"onReservation" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * reservationId = [self checkArgument:call.arguments forKey:@"reservationId" ofType:[NSString class]];
        NSString * category = [self checkArgument:call.arguments forKey:@"category" ofType:[NSString class]];
        NSString * amount = [self checkArgument:call.arguments forKey:@"amount" ofType:[NSNumber class]];
        NSString * term = [self checkArgument:call.arguments forKey:@"term" ofType:[NSString class]];
        [TalkingDataAppCpa onReservation:profile reservationId:reservationId category:category amount:amount.intValue term:term];
    }else if([@"onBooking" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * bookingId = [self checkArgument:call.arguments forKey:@"bookingId" ofType:[NSString class]];
        NSString * category = [self checkArgument:call.arguments forKey:@"category" ofType:[NSString class]];
        NSString * amount = [self checkArgument:call.arguments forKey:@"amount" ofType:[NSNumber class]];
        NSString * content = [self checkArgument:call.arguments forKey:@"content" ofType:[NSString class]];
        [TalkingDataAppCpa onBooking:profile bookingId:bookingId category:category amount:amount.intValue content:content];
    }else if([@"onContact" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * content = [self checkArgument:call.arguments forKey:@"content" ofType:[NSString class]];
        if (profile && content) {
            [TalkingDataAppCpa onContact:profile content:content];
        }
    }else if([@"onViewItemWithCategory" isEqualToString:call.method]){
        NSString * category = [self checkArgument:call.arguments forKey:@"category" ofType:[NSString class]];
        NSString * itemId = [self checkArgument:call.arguments forKey:@"itemId" ofType:[NSString class]];
        NSString * name = [self checkArgument:call.arguments forKey:@"name" ofType:[NSString class]];
        NSNumber * unitPrice = [self checkArgument:call.arguments forKey:@"unitPrice" ofType:[NSNumber class]];
        [TalkingDataAppCpa onViewItemWithCategory:category itemId:itemId name:name unitPrice:unitPrice.intValue];
    }else if([@"onViewShoppingCart" isEqualToString:call.method]){
        NSArray * shoppingCartDetails = [self checkArgument:call.arguments forKey:@"shoppingCartDetails" ofType:[NSArray class]];
        TDShoppingCart * sc = [TDShoppingCart createShoppingCart];
        for (NSDictionary* each in shoppingCartDetails) {
            NSNumber * amount = [self checkArgument:each forKey:@"amount" ofType:[NSNumber class]];
            NSString * category = [self checkArgument:each forKey:@"category" ofType:[NSString class]];
            NSString * itemID = [self checkArgument:each forKey:@"itemID" ofType:[NSString class]];
            NSString * name = [self checkArgument:each forKey:@"name" ofType:[NSString class]];
            NSNumber * uniprice = [self checkArgument:each forKey:@"unitPrice" ofType:[NSNumber class]];
            [sc addItemWithCategory:category itemId:itemID name:name unitPrice:uniprice.intValue amount:amount.intValue];
        }
        [TalkingDataAppCpa onViewShoppingCart:sc];
    }else if ([@"onAddItemToShoppingCart" isEqualToString:call.method]){
        NSNumber * amount = [self checkArgument:call.arguments forKey:@"amount" ofType:[NSNumber class]];
        NSString * category = [self checkArgument:call.arguments forKey:@"category" ofType:[NSString class]];
        NSString * itemID = [self checkArgument:call.arguments forKey:@"itemID" ofType:[NSString class]];
        NSString * name = [self checkArgument:call.arguments forKey:@"name" ofType:[NSString class]];
        NSNumber * uniprice = [self checkArgument:call.arguments forKey:@"unitPrice" ofType:[NSNumber class]];
        [TalkingDataAppCpa onAddItemToShoppingCartWithCategory:category itemId:itemID name:name unitPrice:uniprice.intValue amount:amount.intValue];
    }else if ([@"onPlaceOrder" isEqualToString:call.method]){
        NSString * profileID = [self checkArgument:call.arguments forKey:@"profileID" ofType:[NSString class]];
        NSString * currencyType = [self checkArgument:call.arguments forKey:@"currencyType" ofType:[NSString class]];
        NSArray * orderDetails = [self checkArgument:call.arguments forKey:@"orderDetails" ofType:[NSArray class]];
        NSString * orderID = [self checkArgument:call.arguments forKey:@"orderID" ofType:[NSString class]];
        NSNumber * totalPrice = [self checkArgument:call.arguments forKey:@"totalPrice" ofType:[NSNumber class]];
        TDOrder * order = [TDOrder orderWithOrderId:orderID total:totalPrice.intValue currencyType:currencyType];
        for (NSDictionary * each in orderDetails) {
            NSNumber * amount = [self checkArgument:each forKey:@"amount" ofType:[NSNumber class]];
            NSString * category = [self checkArgument:each forKey:@"category" ofType:[NSString class]];
            NSString * itemID = [self checkArgument:each forKey:@"itemID" ofType:[NSString class]];
            NSString * name = [self checkArgument:each forKey:@"name" ofType:[NSString class]];
            NSNumber * uniprice = [self checkArgument:each forKey:@"unitPrice" ofType:[NSNumber class]];
            [order addItemWithCategory:category itemId:itemID name:name unitPrice:uniprice.intValue amount:amount.intValue];
        }
        [TalkingDataAppCpa onPlaceOrder:profileID withOrder:order];
    }else if([@"onPay1" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * orderId = [self checkArgument:call.arguments forKey:@"orderId" ofType:[NSString class]];
        NSNumber * amount = [self checkArgument:call.arguments forKey:@"amount" ofType:[NSNumber class]];
        NSString * currencyType = [self checkArgument:call.arguments forKey:@"currencyType" ofType:[NSString class]];
        NSString * payType = [self checkArgument:call.arguments forKey:@"payType" ofType:[NSString class]];
        [TalkingDataAppCpa onPay:profile withOrderId:orderId withAmount:amount.intValue withCurrencyType:currencyType withPayType:payType];
    }else if([@"onPay2" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * orderId = [self checkArgument:call.arguments forKey:@"orderId" ofType:[NSString class]];
        NSNumber * amount = [self checkArgument:call.arguments forKey:@"amount" ofType:[NSNumber class]];
        NSString * currencyType = [self checkArgument:call.arguments forKey:@"currencyType" ofType:[NSString class]];
        NSString * payType = [self checkArgument:call.arguments forKey:@"payType" ofType:[NSString class]];
        NSString * ordercurrencyType = [self checkArgument:call.arguments forKey:@"ordercurrencyType" ofType:[NSString class]];
        NSArray * orderDetails = [self checkArgument:call.arguments forKey:@"orderDetails" ofType:[NSArray class]];
        NSString * orderID = [self checkArgument:call.arguments forKey:@"orderID" ofType:[NSString class]];
        NSNumber * totalPrice = [self checkArgument:call.arguments forKey:@"totalPrice" ofType:[NSNumber class]];
        TDOrder * order = [TDOrder orderWithOrderId:orderID total:totalPrice.intValue currencyType:ordercurrencyType];
        for (NSDictionary * each in orderDetails) {
            NSNumber * amount = [self checkArgument:each forKey:@"amount" ofType:[NSNumber class]];
            NSString * category = [self checkArgument:each forKey:@"category" ofType:[NSString class]];
            NSString * itemID = [self checkArgument:each forKey:@"itemID" ofType:[NSString class]];
            NSString * name = [self checkArgument:each forKey:@"name" ofType:[NSString class]];
            NSNumber * uniprice = [self checkArgument:each forKey:@"unitPrice" ofType:[NSNumber class]];
            [order addItemWithCategory:category itemId:itemID name:name unitPrice:uniprice.intValue amount:amount.intValue];
        }
        [TalkingDataAppCpa onPay:profile withOrderId:orderId withAmount:amount.intValue withCurrencyType:currencyType withPayType:payType withOrder:order];
        
    }else if([@"onPay3" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * orderId = [self checkArgument:call.arguments forKey:@"orderId" ofType:[NSString class]];
        NSNumber * amount = [self checkArgument:call.arguments forKey:@"amount" ofType:[NSNumber class]];
        NSString * currencyType = [self checkArgument:call.arguments forKey:@"currencyType" ofType:[NSString class]];
        NSString * payType = [self checkArgument:call.arguments forKey:@"payType" ofType:[NSString class]];
        NSString * itemId = [self checkArgument:call.arguments forKey:@"itemId" ofType:[NSString class]];
        NSNumber * itemCount = [self checkArgument:call.arguments forKey:@"itemCount" ofType:[NSNumber class]];
        [TalkingDataAppCpa onPay:profile withOrderId:orderId withAmount:amount.intValue withCurrencyType:currencyType withPayType:payType withItemId:itemId withItemCount:itemCount.intValue];
    }else if([@"onLearn" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * course = [self checkArgument:call.arguments forKey:@"course" ofType:[NSString class]];
        NSNumber * begin = [self checkArgument:call.arguments forKey:@"begin" ofType:[NSNumber class]];
        NSNumber * duration = [self checkArgument:call.arguments forKey:@"duration" ofType:[NSNumber class]];
        [TalkingDataAppCpa onLearn:profile course:course begin:begin.longLongValue duration:duration.intValue];
    }else if([@"onRead" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * book = [self checkArgument:call.arguments forKey:@"book" ofType:[NSString class]];
        NSNumber * begin = [self checkArgument:call.arguments forKey:@"begin" ofType:[NSNumber class]];
        NSNumber * duration = [self checkArgument:call.arguments forKey:@"duration" ofType:[NSNumber class]];
        [TalkingDataAppCpa onRead:profile book:book begin:begin.longLongValue duration:duration.intValue];
    }else if([@"onBrowse" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * content = [self checkArgument:call.arguments forKey:@"content" ofType:[NSString class]];
        NSNumber * begin = [self checkArgument:call.arguments forKey:@"begin" ofType:[NSNumber class]];
        NSNumber * duration = [self checkArgument:call.arguments forKey:@"duration" ofType:[NSNumber class]];
        [TalkingDataAppCpa onBrowse:profile content:content begin:begin.longLongValue duration:duration.intValue];
    }else if([@"onTransaction" isEqualToString:call.method]){
        //to do with object
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        
        NSString * transactionId = [self checkArgument:call.arguments forKey:@"transactionId" ofType:[NSString class]];
        NSString * category = [self checkArgument:call.arguments forKey:@"category" ofType:[NSString class]];
        NSNumber * amount = [self checkArgument:call.arguments forKey:@"amount" ofType:[NSNumber class]];
        NSString * personA = [self checkArgument:call.arguments forKey:@"personA" ofType:[NSString class]];
        NSString * personB = [self checkArgument:call.arguments forKey:@"personB" ofType:[NSString class]];
        NSNumber * startDate = [self checkArgument:call.arguments forKey:@"startDate" ofType:[NSNumber class]];
        NSNumber * endDate = [self checkArgument:call.arguments forKey:@"endDate" ofType:[NSNumber class]];
        NSString * currencyType = [self checkArgument:call.arguments forKey:@"currencyType" ofType:[NSString class]];
        NSString * content = [self checkArgument:call.arguments forKey:@"content" ofType:[NSString class]];

        TDTransaction * transaction = [[TDTransaction alloc]init];
        transaction.transactionId = transactionId;
        transaction.category = category;
        transaction.amount = amount.intValue;
        transaction.personA = personA;
        transaction.personB = personB;
        transaction.category = category;
        transaction.category = category;
        transaction.startDate = startDate.longLongValue;
        transaction.endDate = endDate.longLongValue;
        transaction.currencyType = currencyType;
        transaction.content = content;
        
        [TalkingDataAppCpa onTransaction:profile transaction:transaction];
        
    }else if ([@"onCredit" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSNumber * amount = [self checkArgument:call.arguments forKey:@"amount" ofType:[NSNumber class]];
        NSString * content = [self checkArgument:call.arguments forKey:@"content" ofType:[NSString class]];
        [TalkingDataAppCpa onCredit:profile amount:amount.intValue content:content];
    }else if([@"onChargeBack" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * orderId = [self checkArgument:call.arguments forKey:@"orderId" ofType:[NSString class]];
        NSString * reason = [self checkArgument:call.arguments forKey:@"reason" ofType:[NSString class]];
        NSString * type = [self checkArgument:call.arguments forKey:@"type" ofType:[NSString class]];
        [TalkingDataAppCpa onChargeBack:profile orderId:orderId reason:reason type:type];
    }else if ([@"onCreateRole" isEqualToString:call.method]){
        NSString * name = [self checkArgument:call.arguments forKey:@"name" ofType:[NSString class]];
        [TalkingDataAppCpa onCreateRole:name];
    }else if([@"onTrialFinished" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * content = [self checkArgument:call.arguments forKey:@"content" ofType:[NSString class]];
        [TalkingDataAppCpa onTrialFinished:profile content:content];
    }else if([@"onGuideFinished" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * content = [self checkArgument:call.arguments forKey:@"content" ofType:[NSString class]];
        [TalkingDataAppCpa onGuideFinished:profile content:content];
    }else if([@"onPreviewFinished" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * content = [self checkArgument:call.arguments forKey:@"content" ofType:[NSString class]];
        [TalkingDataAppCpa onPreviewFinished:profile content:content];
    }else if([@"onFreeFinished" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * content = [self checkArgument:call.arguments forKey:@"content" ofType:[NSString class]];
        [TalkingDataAppCpa onFreeFinished:profile content:content];
    }else if([@"onLevelPass" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * levelId = [self checkArgument:call.arguments forKey:@"levelId" ofType:[NSString class]];
        [TalkingDataAppCpa onLevelPass:profile levelId:levelId];
    }else if([@"onAchievementUnlock" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * achievementId = [self checkArgument:call.arguments forKey:@"achievementId" ofType:[NSString class]];
        [TalkingDataAppCpa onAchievementUnlock:profile achievementId:achievementId];
    }else if([@"onOrderPaySucc" isEqualToString:call.method]){
        NSString * profile = [self checkArgument:call.arguments forKey:@"profile" ofType:[NSString class]];
        NSString * orderId = [self checkArgument:call.arguments forKey:@"orderId" ofType:[NSString class]];
        NSNumber * amount = [self checkArgument:call.arguments forKey:@"amount" ofType:[NSNumber class]];
        NSString * currencyType = [self checkArgument:call.arguments forKey:@"currencyType" ofType:[NSString class]];
        NSString * payType = [self checkArgument:call.arguments forKey:@"payType" ofType:[NSString class]];
        [TalkingDataAppCpa onOrderPaySucc:profile withOrderId:orderId withAmount:amount.intValue withCurrencyType:currencyType withPayType:payType];
    }else if ([@"onCustEvent1" isEqualToString:call.method]){
        [TalkingDataAppCpa onCustEvent1];
    }else if ([@"onCustEvent2" isEqualToString:call.method]){
        [TalkingDataAppCpa onCustEvent2];
    } else if ([@"onCustEvent3" isEqualToString:call.method]){
        [TalkingDataAppCpa onCustEvent3];
    } else if ([@"onCustEvent4" isEqualToString:call.method]){
        [TalkingDataAppCpa onCustEvent4];
    } else if ([@"onCustEvent5" isEqualToString:call.method]){
        [TalkingDataAppCpa onCustEvent5];
    } else if ([@"onCustEvent6" isEqualToString:call.method]){
        [TalkingDataAppCpa onCustEvent6];
    } else if ([@"onCustEvent7" isEqualToString:call.method]){
        [TalkingDataAppCpa onCustEvent7];
    } else if ([@"onCustEvent8" isEqualToString:call.method]){
        [TalkingDataAppCpa onCustEvent8];
    } else if ([@"onCustEvent9" isEqualToString:call.method]){
        [TalkingDataAppCpa onCustEvent9];
    } else if ([@"onCustEvent10" isEqualToString:call.method]){
        [TalkingDataAppCpa onCustEvent10];
    }  else if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }else if ([@"getDeviceID" isEqualToString:call.method]){
       NSString * deviceid = [TalkingDataAppCpa getDeviceId];
        NSLog(@"OC getDeviceID:%@",deviceid);
       result(deviceid);
    }  else {
    result(FlutterMethodNotImplemented);
  }
}

@end

