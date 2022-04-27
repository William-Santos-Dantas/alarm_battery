import 'package:get/get.dart';
import '../../application/ui/loader/loader_mixin.dart';
import '../../application/ui/messages/messages_mixin.dart';

class HomeController extends GetxController with LoaderMixin, MessagesMixin {
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();
  // ignore: constant_identifier_names
  static const NAVIGATION_KEY = 1;

  final _pages = ['/alarm', '/historic', '/settings', '/about'];
  final _pageIndex = 0.obs;
  int get pageIndex => _pageIndex.value;

  HomeController();

  @override
  void onInit() async {
    super.onInit();
    loaderListener(_loading);
    messageListener(_message);
  }


  void goToPage(int page) {
    _pageIndex(page);
    Get.offNamed(_pages[page], id: NAVIGATION_KEY);
  }
}
