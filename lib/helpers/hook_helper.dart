import 'package:dio/dio.dart';
import 'package:logger/web.dart';

mixin HookHelper {
  static Future<void> postWebHook(String? url) async {
    if (url == null || url.isEmpty) {
      return;
    }

    try {
      Logger().d('POSTing webhook to $url');

      final dio = Dio();

      final options = Options(
        validateStatus: (status) => status != null && status == 200,
      );

      await dio.post<dynamic>(url, options: options);
    } catch (e, s) {
      Logger().e('Failed to POST webhook to $url', error: e, stackTrace: s);
    }
  }
}
