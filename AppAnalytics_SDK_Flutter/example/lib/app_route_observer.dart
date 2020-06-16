import 'package:flutter/widgets.dart';
import 'package:talkingdata_appanalytics_plugin/talkingdata_appanalytics_plugin.dart';

class TalkingDataRouteObserver extends RouteObserver<PageRoute>{
  String _getRouteName(Route<dynamic> route) => route.settings.name;


  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute){
    super.didPush(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      if(previousRoute.settings.name != null){
        TalkingDataAppAnalytics.onPageEnd(previousRoute.settings.name);
      }

      if(route.settings.name != null){
        TalkingDataAppAnalytics.onPageStart(route.settings.name);
      }
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      if(route.settings.name != null){
        TalkingDataAppAnalytics.onPageEnd(route.settings.name);
      }

      if(previousRoute.settings.name != null){
        TalkingDataAppAnalytics.onPageStart(previousRoute.settings.name);
      }
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      if(oldRoute.settings.name != null){
        TalkingDataAppAnalytics.onPageEnd(oldRoute.settings.name);
      }

      if(newRoute.settings.name != null){
        TalkingDataAppAnalytics.onPageStart(newRoute.settings.name);
      }
    }
  }

}