import 'package:flutter/material.dart';
import 'subpage/base_statistics.dart';
import 'subpage/page_statistics.dart';
import 'subpage/custom_event.dart';
import 'subpage/standard_event.dart';

class MainPageItemDetail{
  MainPageItemDetail({
    this.icon,
    this.title,
    this.content,
    this.pageName
  });

  var icon;
  var title;
  var content;
  var pageName;

}


class PageSelector{
  static Widget getPageContent(String pageName){
    switch(pageName){
      case 'BaseStatisticsPage':
        return BaseStatisticsPage();
      case 'PageStatisticsPage':
        return PageStatisticsPage();
      case 'CustomEventPage':
        return CustomEventPage();
      case 'StandardEventPage':
        return StandardEventPage();
    }
    return null;
  }
}
