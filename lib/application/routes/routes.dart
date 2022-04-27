import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../modules/home/home_module.dart';
class Routes {
  static List<GetPage<dynamic>> routes = [
    ...HomeModule().routers,
  ];
}
