package com.talkingdata.plugin.appanalytics_example;

import android.os.Bundle;

import com.tendcloud.tenddata.TCAgent;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    TCAgent.init(getApplicationContext(), "aaa", "bbb");
  }
}
