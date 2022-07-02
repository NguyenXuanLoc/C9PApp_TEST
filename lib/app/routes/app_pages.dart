import 'package:get/get.dart';

import '../modules/detail_order/bindings/detail_order_binding.dart';
import '../modules/detail_order/views/detail_order_view.dart';
import '../modules/developing/bindings/developing_binding.dart';
import '../modules/developing/views/developing_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login_splash/bindings/login_splash_binding.dart';
import '../modules/login_splash/views/login_splash_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/order_success/bindings/order_success_binding.dart';
import '../modules/order_success/views/order_success_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/tab_account/bindings/tab_account_binding.dart';
import '../modules/tab_account/views/tab_account_view.dart';
import '../modules/tab_main/bindings/tab_main_binding.dart';
import '../modules/tab_main/views/tab_main_view.dart';
import '../modules/tab_notify/bindings/tab_notify_binding.dart';
import '../modules/tab_notify/views/tab_notify_view.dart';
import '../modules/tab_promotion/bindings/tab_promotion_binding.dart';
import '../modules/tab_promotion/views/tab_promotion_view.dart';
import '../modules/test/bindings/test_binding.dart';
import '../modules/test/views/test_view.dart';
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/update_profile_view.dart';
import '../modules/your_order/bindings/your_order_binding.dart';
import '../modules/your_order/views/your_order_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      preventDuplicates: false,
      bindings: [
        HomeBinding(),
        TabMainBinding(),
        TabPromotionBinding(),
        TabNotifyBinding(),
        TabAccountBinding()
      ],
    ),
    GetPage(
      name: _Paths.LOGIN_SPLASH,
      page: () => LoginSplashView(),
      binding: LoginSplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.TAB_MAIN,
      page: () => TabMainView(),
      binding: TabMainBinding(),
    ),
    GetPage(
      name: _Paths.TAB_PROMOTION,
      page: () => TabPromotionView(),
      binding: TabPromotionBinding(),
    ),
    GetPage(
      name: _Paths.TAB_NOTIFY,
      page: () => TabNotifyView(),
      binding: TabNotifyBinding(),
    ),
    GetPage(
      name: _Paths.TAB_ACCOUNT,
      page: () => TabAccountView(),
      binding: TabAccountBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ORDER,
      page: () => DetailOrderView(),
      binding: DetailOrderBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.DEVELOPING,
      page: () => DevelopingView(),
      binding: DevelopingBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_SUCCESS,
      page: () => OrderSuccessView(),
      binding: OrderSuccessBinding(),
    ),
    GetPage(
      name: _Paths.YOUR_ORDER,
      page: () => YourOrderView(),
      binding: YourOrderBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.TEST,
      page: () => TestView(),
      binding: TestBinding(),
    ),
  ];
}
