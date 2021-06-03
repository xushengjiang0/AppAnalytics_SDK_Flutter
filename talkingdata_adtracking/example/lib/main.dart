import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:talkingdata_adtracking/talkingdata_adtracking.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String deviceID;
  String oaid;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await TalkingdataAdtracking.platformVersion;

    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body:  new ListView(
            children: [
              RaisedButton(child: Text('init'),onPressed: (){
                TalkingdataAdtracking.init(appID:"Your App ID",channelID:"Your Channel ID");
              }),
              RaisedButton(child: Text('initWithCustom'),onPressed: (){
                TalkingdataAdtracking.initWithCustom(appID:"Your App ID",channelID:"Your Channel ID",adtCustom:"Your Custom");
              }),
              RaisedButton(child: Text('getDeviceID'),onPressed: (){
                _setDeviceID();
              }),
              RaisedButton(child: Text('getOAID'),onPressed: (){
                Future.delayed(Duration(seconds:3),(){
                  _setOAID();
                });
              }),
              RaisedButton(child: Text('onRegister'),onPressed: (){
                String profile = "user01";
                TalkingdataAdtracking.onRegister(profile);
              }),
              RaisedButton(child: Text('onRegisterWithInvitationCode'),onPressed: (){
                String profile = "user01";
                String invitationCode = "1001";
                TalkingdataAdtracking.onRegisterWithInvitationCode(profile,invitationCode);
              }),
              RaisedButton(child: Text('onLogin'),onPressed: (){
                String profile = "user01";
                TalkingdataAdtracking.onLogin(profile);
              }),
              RaisedButton(child: Text('onCreateCard'),onPressed: (){
                String profile = "user01";
                String method = "WePay";
                String content = "Game-Item-02";
                TalkingdataAdtracking.onCreateCard(profile,method,content);
              }),
              RaisedButton(child: Text('onReceiveDeepLink'),onPressed: (){
                String link = "https://www.talkingdata.com";
                TalkingdataAdtracking.onReceiveDeepLink(link);
              }),
              RaisedButton(child: Text('onFavorite'),onPressed: (){
                String category = "book";
                String content = "GodFather";
                TalkingdataAdtracking.onFavorite(category,content);
              }),
              RaisedButton(child: Text('onShare'),onPressed: (){
                String profile = "user01";
                String content = "best content";
                TalkingdataAdtracking.onShare(profile,content);
              }),
              RaisedButton(child: Text('onPunch'),onPressed: (){
                String profile = "user01";
                String punchid = "punchId01";
                TalkingdataAdtracking.onPunch(profile,punchid);
              }),
              RaisedButton(child: Text('onSearch'),onPressed: (){
                TDADTSearch search = TDADTSearch(
                  category : "Book",
                  content  : "Book's content",
                  itemId : "item-001",
                  itemLocationId : "itemLocationId-001",
                  destination : "Beijing",
                  origin : "ShangHai",
                  startDate : 1586669180,
                  endDate : 1587101180,
                );
                TalkingdataAdtracking.onSearch(search);
              }),
              RaisedButton(child: Text('onReservation'),onPressed: (){
                String profile = "user01";
                String reservationId = "100921";
                String category = "hotel";
                int amount = 1;
                String term = "MyTerm";
                TalkingdataAdtracking.onReservation(profile,reservationId,category,amount,term);
              }),
              RaisedButton(child: Text('onBooking'),onPressed: (){
                String profile = "user01";
                String bookId = "60018";
                String category = "hotel";
                int amount = 1;
                String term = "MyTerm";
                TalkingdataAdtracking.onBooking(profile,bookId,category,amount,term);
              }),
              RaisedButton(child: Text('onContact'),onPressed: (){
                String profile = "user01";
                String content = "MyContent";
                TalkingdataAdtracking.onContact(profile,content);
              }),
              RaisedButton(child: Text('onViewItemWithCategory'),onPressed: (){
                String category = "Book";
                String itemId = "9112";
                String name = "GodFather";
                int unitPrice = 99;
                TalkingdataAdtracking.onViewItemWithCategory(category,itemId,name,unitPrice);
              }),
              RaisedButton(child: Text('onViewShoppingCart'),onPressed: (){
                TDADTShoppingCart shoppingCart = TDADTShoppingCart();
                shoppingCart.addItem('itemID331135516', 'Food', 'apple', 33, 11);
                shoppingCart.addItem('itemID333103428', 'Food', 'banana', 777, 888);
                TalkingdataAdtracking.onViewShoppingCart(shoppingCart);
              }),
              RaisedButton(child: Text('onPlaceOrder'),onPressed: (){
                TDADTOrder order = TDADTOrder(
                  orderID: 'orderID102',
                  totalPrice: 1,
                  currencyType: 'CNY',
                );
                order.addItem('testID', 'Food', 'apple', 22, 33);
                TalkingdataAdtracking.onPlaceOrder(
                  profileID: 'user-01',
                  order: order
                );
              }),
              RaisedButton(child: Text('onPay1'),onPressed: (){
                String profile = "user-01";
                String orderId = "oid001";
                int amount = 12;
                String currencyType = "CNY";
                String payType = "AliPay";
                TalkingdataAdtracking.onPay1(profile,orderId,amount,currencyType,payType);
              }),
              RaisedButton(child: Text('onPay2'),onPressed: (){
                String profile = "user-01";
                String orderId = "oid001";
                int amount = 12;
                String currencyType = "CNY";
                String payType = "AliPay";
                TDADTOrder order = TDADTOrder(
                  orderID: 'orderID102',
                  totalPrice: 1,
                  currencyType: 'CNY',
                );
                order.addItem('testID', 'Food', 'apple', 22, 33);
                TalkingdataAdtracking.onPay2(profile,orderId,amount,currencyType,payType,order);
              }),
              RaisedButton(child: Text('onPay3'),onPressed: (){
                String profile = "user-01";
                String orderId = "oid001";
                int amount = 12;
                String currencyType = "CNY";
                String payType = "AliPay";
                String itemID = "item001";
                int itemCount = 5;
                TalkingdataAdtracking.onPay3(profile,orderId,amount,currencyType,payType,itemID,itemCount);
              }),
              RaisedButton(child: Text('onLearn'),onPressed: (){
                String profile = "user01";
                String course = "Math";
                int begin = 1586669180;
                int duration = 3600;
                TalkingdataAdtracking.onLearn(profile,course,begin,duration);
              }),
              RaisedButton(child: Text('onRead'),onPressed: (){
                String profile = "user01";
                String book = "English";
                int begin = 1586669180;
                int duration = 3600;
                TalkingdataAdtracking.onRead(profile,book,begin,duration);
              }),
              RaisedButton(child: Text('onBrowse'),onPressed: (){
                String profile = "user01";
                String content = "content";
                int begin = 1586669180;
                int duration = 3600;
                TalkingdataAdtracking.onBrowse(profile,content,begin,duration);
              }),
              RaisedButton(child: Text('onTransaction'),onPressed: (){
                TDADTTransaction transaction = TDADTTransaction(
                                    transactionId : "transaction-001",
                                    category  : "Food",
                                    amount : 12,
                                    personA : "Jim",
                                    personB : "Tom",
                                    startDate : 1586669180,
                                    endDate : 1587101180,
                                    currencyType : "CNY",
                                    content : "Chicken",
                                  );
                TalkingdataAdtracking.onTransaction("user-01",transaction);
              }),
              RaisedButton(child: Text('onCredit'),onPressed: (){
                String profile = "user01";
                int amount = 2;
                String content = "content";
                TalkingdataAdtracking.onCredit(profile,amount,content);
              }),
              RaisedButton(child: Text('onChargeBack'),onPressed: (){
                String profile = "user01";
                String orderid = "oid01";
                String reason = "reason";
                String type = "type01";
                TalkingdataAdtracking.onChargeBack(profile,orderid,reason,type);
              }),
              RaisedButton(child: Text('onCreateRole'),onPressed: (){
                String name = "BatMan";
                TalkingdataAdtracking.onCreateRole(name);
              }),
              RaisedButton(child: Text('onTrialFinished'),onPressed: (){
                String profile = "user01";
                String content = "Gaming";
                TalkingdataAdtracking.onTrialFinished(profile,content);
              }),
              RaisedButton(child: Text('onGuideFinished'),onPressed: (){
                String profile = "user01";
                String content = "Gaming";
                TalkingdataAdtracking.onGuideFinished(profile,content);
              }),
              RaisedButton(child: Text('onPreviewFinished'),onPressed: (){
                String profile = "user01";
                String content = "Gaming";
                TalkingdataAdtracking.onPreviewFinished(profile,content);
              }),
              RaisedButton(child: Text('onFreeFinished'),onPressed: (){
                String profile = "user01";
                String content = "Gaming";
                TalkingdataAdtracking.onFreeFinished(profile,content);
              }),
              RaisedButton(child: Text('onLevelPass'),onPressed: (){
                String profile = "user01";
                String levelId = "level01";
                TalkingdataAdtracking.onLevelPass(profile,levelId);
              }),
              RaisedButton(child: Text('onAchievementUnlock'),onPressed: (){
                String profile = "user01";
                String achievementId = "achievement01";
                TalkingdataAdtracking.onAchievementUnlock(profile,achievementId);
              }),
              RaisedButton(child: Text('onOrderPaySucc'),onPressed: (){
                String profile = "user-01";
                String orderId = "oid001";
                int amount = 12;
                String currencyType = "CNY";
                String payType = "AliPay";
                TalkingdataAdtracking.onOrderPaySucc(profile,orderId,amount,currencyType,payType);
              }),
              RaisedButton(child: Text('onCustEvent1'),onPressed: (){TalkingdataAdtracking.onCustEvent1();}),
              RaisedButton(child: Text('onCustEvent2'),onPressed: (){TalkingdataAdtracking.onCustEvent2();}),
              RaisedButton(child: Text('onCustEvent3'),onPressed: (){TalkingdataAdtracking.onCustEvent3();}),
              RaisedButton(child: Text('onCustEvent4'),onPressed: (){TalkingdataAdtracking.onCustEvent4();}),
              RaisedButton(child: Text('onCustEvent5'),onPressed: (){TalkingdataAdtracking.onCustEvent5();}),
              RaisedButton(child: Text('onCustEvent6'),onPressed: (){TalkingdataAdtracking.onCustEvent6();}),
              RaisedButton(child: Text('onCustEvent7'),onPressed: (){TalkingdataAdtracking.onCustEvent7();}),
              RaisedButton(child: Text('onCustEvent8'),onPressed: (){TalkingdataAdtracking.onCustEvent8();}),
              RaisedButton(child: Text('onCustEvent9'),onPressed: (){TalkingdataAdtracking.onCustEvent9();}),
              RaisedButton(child: Text('onCustEvent10'),onPressed: (){TalkingdataAdtracking.onCustEvent10();}),


            ],

          ),


      ),
    );
  }

  _setDeviceID() async{
    deviceID =  await TalkingdataAdtracking.getDeviceID();
    //Print deviceID or dosomething
    print(deviceID);
  }

  _setOAID() async{
    oaid =  await TalkingdataAdtracking.getOAID();
    //Print deviceID or dosomething
    print(oaid);
  }
}
