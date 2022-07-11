import 'dart:ui';

import 'package:get/get.dart';

class AppTranslation extends Translations {
  static var fallbackLocale = const Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'pl': Locales.en,
        'vi': Locales.en,
        'en': Locales.en,
      };
}

class LocaleKeys {
  LocaleKeys._();

  static const ask_existing_page = 'ask_existing_page';
  static const network_error = 'network_error';
  static const com_9p_wellcome = 'com_9p_wellcome';
  static const welcome_to_com_9_p = 'welcome_to_com_9_p';
  static const here_have_dish = 'here_have_dish';
  static const login = 'login';
  static const accept_with = 'accept_with';
  static const regulation = 'regulation';
  static const rules = 'rules';
  static const va = 'va';
  static const login_by_phone_registed = 'login_by_phone_registed';
  static const phone_number = 'phone_number';
  static const phone_number_of_you = 'phone_number_of_you';
  static const phone_number_khong_hop_le = 'phone_number_khong_hop_le';
  static const phone_number_hop_le = 'phone_number_hop_le';
  static const please_input_phone_number = 'please_input_phone_number';
  static const send_otp = 'send_otp';
  static const otp_sent = 'otp_sent';
  static const ban_vui_long_kiem_tra_tin_nhan =
      'ban_vui_long_kiem_tra_tin_nhan';
  static const continues = 'continues';
  static const otp = 'otp';
  static const resent_otp = 'resent_otp';
  static const otp_het_han = 'otp_het_han';
  static const otp_invalid = 'otp_invalid';
  static const please_input_otp = 'please_input_otp';
  static const wrong_otp = 'wrong_otp';
  static const main = 'main';
  static const promotion = 'promotion';
  static const notify = 'notify';
  static const account = 'account';
  static const menu = 'menu';
  static const order = 'order';
  static const statistical = 'statistical';
  static const more = 'more';
  static const the_order_has_delivered = 'the_order_has_delivered';
  static const delivered = 'delivered';
  static const re_order = 're_order';
  static const re_deliver = 're_deliver';
  static const address = 'address';
  static const code = 'code';
  static const temp = 'temp';
  static const find_order_at_here = 'find_order_at_here';
  static const com_suong_9p = 'com_suong_9p';
  static const time = 'time';
  static const address_order = 'address_order';
  static const shipper = 'shipper';
  static const order_time = 'order_time';
  static const delivery_time = 'delivery_time';
  static const full_name = 'full_name';
  static const delivery_address = 'delivery_address';
  static const delivery_date = 'delivery_date';
  static const choose_number = 'choose_number';
  static const please_input_full_name = 'please_input_full_name';
  static const please_input_delivery_add = 'please_input_delivery_add';
  static const please_input_delivery_date = 'please_input_delivery_date';
  static const please_input_delivery_hours = 'please_input_delivery_hours';
  static const please_input_count = 'please_input_count';
  static const developing = 'developing';
  static const reorder_rice = 'reorder_rice';
  static const order_success = 'order_success';
  static const follow_order = 'follow_order';
  static const order_succes_choose_option = 'order_succes_choose_option';
  static const order_are_coming = 'order_are_coming';
  static const order_delivered = 'order_delivered';
  static const your_order = 'your_order';
  static const sex = 'sex';
  static const male = 'male';
  static const female = 'female';
  static const update = 'update';
  static const gallery = 'gallery';
  static const camera = 'camera';
  static const near_order = 'near_order';
  static const bowl_of_rice = 'bowl_of_rice';
  static const input_phone_number_at_here = 'input_phone_number_at_here';
  static const input_full_name = 'input_full_name';
  static const input_address_at_here = 'input_address_at_here';
  static const input_qty = 'input_qty';
  static const cancel = 'cancel';
  static const yes = 'yes';
  static const hours = 'hours';
  static const minutes = 'minutes';
  static const not_data_pull_to_refresh = 'not_data_pull_to_refresh';
  static const not_find_address_please_try_again =
      'not_find_address_please_try_again';
  static const not_order_pull_to_refresh = 'not_order_pull_to_refresh';
  static const received = 'received';
  static const save = 'save';
  static const logout = 'logout';
  static const refresh_list = 'refresh_list';
  static const add_order = 'add_order';
  static const input_phone_number_to_order_c9p =
      'input_phone_number_to_order_c9p';
  static const register_now = 'register_now';
  static const do_you_not_have_account = 'do_you_not_have_account';
  static const please_input_info_at_here = 'please_input_info_at_here';
  static const name = 'name';
  static const register_success = 'register_success';
  static const message_register_success = 'message_register_success';
  static const net_work_error_click_to_retry = 'net_work_error_click_to_retry';
  static const token_expire = 'token_expire';
}

class Locales {
  static const en = {
    'ask_existing_page': 'EnglishEnglishEnglishEnglishEnglish',
    'network_error': 'Lỗi mạng, vui lòng thử lại sau.',
    'com_9p_wellcome': 'Cơm 9 phút xin chào!',
    'here_have_dish': 'Ở đây có món ngon bạn thích.',
    'login': 'Đăng nhập',
    'accept_with': 'Bằng việc đăng ký hoặc đăng nhập, bạn đã đồng ý với các',
    'regulation': 'Điều khoản dịch vụ',
    'rules': 'Chính sách bảo mật',
    'va': 'và',
    'phone_number': 'Số điện thoại',
    'phone_number_of_you': 'Số điện thoại của bạn',
    'phone_number_khong_hop_le': 'Số điện thoại không hợp lệ',
    'phone_number_hop_le': 'Số điện thoại hợp lệ',
    'please_input_phone_number': 'Vui lòng nhập số điện thoại',
    'send_otp': 'Đã gửi mã OTP',
    'continues': 'Tiếp tục',
    'otp': 'OTP',
    'otp_sent': 'Mã được gửi tới số',
    'resent_otp': 'Gửi lại mã OTP',
    'otp_invalid': 'Mã Otp không hợp lệ',
    'otp_het_han':
        'Mã OTP đã hết hạn, vui lòng click "Gửi lại mã OTP" để lấy 1 mã OTP khác.',
    'wrong_otp': 'Mã OTP không đúng, vui lòng thử lại.',
    'please_input_otp': 'Vui lòng nhập mã Otp.',
    'ban_vui_long_kiem_tra_tin_nhan':
        'bạn vui lòng nhập kiểm tra tin nhắn và nhập vào ô bên dưới',
    'login_by_phone_registed':
        'Đăng nhập bằng cách điền số điện thoại của bạn đã đăng ký',
    'main': 'Trang chủ',
    'promotion': 'Khuyến mại',
    'notify': 'Thông báo',
    'account': 'Tài khoản',
    'menu': 'Menu',
    'order': 'Đơn hàng',
    'statistical': 'Thống kê',
    'more': 'Khác',
    'the_order_has_delivered': 'Đơn đã giao',
    'delivered': 'Đã giao hàng',
    're_order': 'Đặt lại',
    're_deliver': 'Giao lại',
    'address': 'Địa chỉ',
    'code': 'Mã',
    'temp': 'Nhiệt độ',
    'find_order_at_here': 'Tìm ID đơn hàng tại đây',
    'com_suong_9p': 'Cơm sườn ngon 9 phút',
    'time': 'Thời gian',
    'address_order': 'Địa chỉ nhận hàng',
    'shipper': 'Shipper',
    'order_time': 'Thời gian đặt hàng',
    'delivery_time': 'Thời gian nhận hàng',
    'full_name': 'Họ & tên',
    'delivery_address': 'Địa chỉ nhận hàng',
    'delivery_date': 'Ngày nhận hàng',
    'choose_number': 'Chọn số suất',
    'please_input_full_name': 'Vui lòng nhập họ và tên',
    'please_input_delivery_add': 'Vui lòng nhập và chọn đúng địa chỉ nhận hàng',
    'please_input_delivery_date': 'Thiếu thông tin',
    'please_input_delivery_hours': 'Thiếu thông tin',
    'please_input_count': 'Vui lòng chọn số suất',
    'developing':
        'Tính năng đang được phát triển, bạn vui lòng\nthử lại vào lần sau nhé',
    'reorder_rice': 'Đặt cơm ngay',
    'order_success': 'Đặt đơn hàng thành công!',
    'follow_order': 'Theo dõi đơn hàng',
    'order_are_coming': 'Đơn hàng đang đến',
    'your_order': 'Đơn hàng của bạn',
    'order_delivered': 'Đơn hàng đã giao',
    'sex': 'Giới tính',
    'male': 'Nam',
    'female': 'Nữ',
    'update': 'Cập nhật',
    'gallery': 'Thư viện',
    'camera': 'Máy ảnh',
    'near_order': 'Đơn đã giao',
    'bowl_of_rice': 'suất cơm',
    'input_address_at_here': 'Nhập địa chỉ đặt hàng tại đây...',
    'input_qty': 'Nhập số suất',
    'input_phone_number_at_here': 'Nhập số điện thoại',
    'input_full_name': 'Nhập họ & tên',
    'cancel': 'Hủy',
    'yes': 'Đồng ý',
    'hours': 'Giờ',
    'minutes': 'Phút',
    'received': 'Đã tiếp nhận',
    'not_data_pull_to_refresh': 'Chưa có dữ liệu\nKéo xuống để tải lại.',
    'not_order_pull_to_refresh': 'Chưa có đơn hàng\nKéo xuống để tải lại.',
    'not_find_address_please_try_again':
        'Không tìm thấy địa chỉ, vui lòng thử lại',
    'save': 'Lưu',
    'logout': 'Đăng xuất',
    'add_order': 'Đặt đơn hàng',
    'refresh_list': 'Tải lại danh sách',
    'welcome_to_com_9_p': 'Chào mừng bạn đến với C9P',
    'input_phone_number_to_order_c9p':
        'Bạn vui lòng điền thêm một số thông tin dưới đây',
    'do_you_not_have_account': 'Chưa có tài khoản',
    'order_succes_choose_option':
        'Đơn hàng của bạn đã được đặt thành công. Vui lòng chọn các thao tác phía dưới',
    'register_now': 'Đăng ký ngay!',
    'name': 'Tên',
    'please_input_info_at_here': 'Bạn vui lòng nhập một số thông tin dưới đây',
    'register_success': 'Đăng ký tài khoản thành công!',
    'net_work_error_click_to_retry': 'Lỗi mạng, ấn để thử lại',
    'token_expire': 'Phiên đăng nhập đã hết hạn',
    'message_register_success':
        'Nhấn nút phía dưới để tiếp tục sử dụng dịch vụ của chúng tôi. Chúc bạn luôn có những bữa trưa ngon miệng',
  };
}
