import 'package:flutter/cupertino.dart';
import '../pages/find_city_page.dart';
import '../pages/home_page.dart';

class Routes {
  Routes();

  static const String home = "home_page";
  static const String find = "page_page";

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => HomePage(),
    find: (context) => FindCityPage(),
  };
}
