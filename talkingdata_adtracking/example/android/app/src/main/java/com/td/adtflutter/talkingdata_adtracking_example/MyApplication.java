package com.td.adtflutter.talkingdata_adtracking_example;

import io.flutter.app.FlutterApplication;
import com.td.adtflutter.talkingdata_adtracking.TalkingdataAdtrackingPlugin;
public class MyApplication extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        String adtAppID = "您的APP ID";
        String adtChannelID = "您的Channel ID";
        String adtCustom = "您的自定义参数 Custom";
        TalkingdataAdtrackingPlugin.init(this,adtAppID,adtChannelID);
//    TalkingdataAdtrackingPlugin.init(this,adtAppID,adtChannelID,adtCustom);
    }
}
