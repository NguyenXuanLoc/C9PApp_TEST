import 'package:get/get.dart';

import '../modules/buy_combo_success/bindings/buy_combo_success_binding.dart';
import '../modules/buy_combo_success/views/buy_combo_success_view.dart';
import '../modules/buy_xu/bindings/buy_xu_binding.dart';
import '../modules/buy_xu/views/buy_xu_view.dart';
import '../modules/by_combo/bindings/by_combo_binding.dart';
import '../modules/by_combo/views/by_combo_view.dart';
import '../modules/change_pass/bindings/change_pass_binding.dart';
import '../modules/change_pass/views/change_pass_view.dart';
import '../modules/combo_selling/bindings/combo_selling_binding.dart';
import '../modules/combo_selling/views/combo_selling_view.dart';
import '../modules/confirm_buy_xu/bindings/confirm_buy_xu_binding.dart';
import '../modules/confirm_buy_xu/views/confirm_buy_xu_view.dart';
import '../modules/confirm_order/bindings/confirm_order_binding.dart';
import '../modules/confirm_order/views/confirm_order_view.dart';
import '../modules/confirm_rice_order/bindings/confirm_rice_order_binding.dart';
import '../modules/confirm_rice_order/views/confirm_rice_order_view.dart';
import '../modules/detail_order/bindings/detail_order_binding.dart';
import '../modules/detail_order/views/detail_order_view.dart';
import '../modules/developing/bindings/developing_binding.dart';
import '../modules/developing/views/developing_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login_by_pin/bindings/login_by_pin_binding.dart';
import '../modules/login_by_pin/views/login_by_pin_view.dart';
import '../modules/login_splash/bindings/login_splash_binding.dart';
import '../modules/login_splash/views/login_splash_view.dart';
import '../modules/my_combo/bindings/my_combo_binding.dart';
import '../modules/my_combo/views/my_combo_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/order_success/bindings/order_success_binding.dart';
import '../modules/order_success/views/order_success_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register_pin/bindings/register_pin_binding.dart';
import '../modules/register_pin/views/register_pin_view.dart';
import '../modules/register_success/bindings/register_success_binding.dart';
import '../modules/register_success/views/register_success_view.dart';
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
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/update_profile_view.dart';
import '../modules/webview/bindings/webview_binding.dart';
import '../modules/webview/views/webview_view.dart';
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
      name: _Paths.REGISTER_SUCCESS,
      page: () => RegisterSuccessView(),
      binding: RegisterSuccessBinding(),
    ),
    GetPage(
      name: _Paths.WEBVIEW,
      page: () => WebviewView(),
      binding: WebviewBinding(),
    ),
    GetPage(
      name: _Paths.MY_COMBO,
      page: () => MyComboView(),
      binding: MyComboBinding(),
    ),
    GetPage(
      name: _Paths.COMBO_SELLING,
      page: () => ComboSellingView(),
      binding: ComboSellingBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_PIN,
      page: () => RegisterPinView(),
      binding: RegisterPinBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_BY_PIN,
      page: () => LoginByPinView(),
      binding: LoginByPinBinding(),
    ),
    GetPage(
      name: _Paths.BY_COMBO,
      page: () => ByComboView(),
      binding: ByComboBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRM_ORDER,
      page: () => ConfirmOrderView(),
      binding: ConfirmOrderBinding(),
    ),
    GetPage(
      name: _Paths.BUY_COMBO_SUCCESS,
      page: () => BuyComboSuccessView(),
      binding: BuyComboSuccessBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRM_RICE_ORDER,
      page: () => ConfirmRiceOrderView(),
      binding: ConfirmRiceOrderBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASS,
      page: () => ChangePassView(),
      binding: ChangePassBinding(),
    ),
    GetPage(
      name: _Paths.BUY_XU,
      page: () => BuyXuView(),
      binding: BuyXuBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRM_BUY_XU,
      page: () => ConfirmBuyXuView(),
      binding: ConfirmBuyXuBinding(),
    ),
  ];
}
