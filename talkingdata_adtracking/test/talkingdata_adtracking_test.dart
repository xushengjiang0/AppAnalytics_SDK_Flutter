import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talkingdata_adtracking/talkingdata_adtracking.dart';

void main() {
  const MethodChannel channel = MethodChannel('talkingdata_adtracking');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await TalkingdataAdtracking.platformVersion, '42');
  });
}
