import 'package:flutter/material.dart';

import 'package:talkingdata_appanalytics_plugin/talkingdata_appanalytics_plugin.dart';

class ProfilePage extends StatefulWidget{

  @override
  State createState(){
    return ProfilePageState();
  }



}

class ProfilePageState extends State<ProfilePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('账户'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                child: Card(
                    child: Column(
                      children: <Widget>[
                        Text('注册'),
                        RaisedButton(
                          child: Text(
                            'onRegister',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onPressed: _onRegister,
                          color: Colors.blueAccent,
                        ),
                      ],
                    )
                )
            ),
            Container(
                width: double.infinity,
                child: Card(
                    child: Column(
                      children: <Widget>[
                        Text('登录'),
                        RaisedButton(
                          child: Text(
                            'onLogin',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onPressed: _onLogin,
                          color: Colors.blueAccent,
                        ),
                      ],
                    )
                )
            ),
          ],
        ),
      ),
    );
  }

  void _onRegister(){
    TalkingDataAppAnalytics.onRegister(
      profileID: 'TestProfileID',
      profileType: ProfileType.WEIXIN,
      name: 'testName'
    );
  }

  void _onLogin(){
    TalkingDataAppAnalytics.onLogin(
      profileID: 'TestProfileID',
      profileType: ProfileType.WEIXIN,
      name: 'testName'
    );
  }
}

