import 'package:dio/dio.dart';
import 'package:logger/web.dart';

enum TriggerMethod {
  get,
  post,
  put,
  patch,
}

mixin HookHelper {
  static Future<void> postWebHook(
    String? url, [
    TriggerMethod? method = TriggerMethod.post,
  ]) async {
    if (url == null || url.isEmpty) {
      return;
    }

    try {
      Logger().d('POSTing webhook to $url');

      final dio = Dio();

      final options = RequestOptions(
        method: method.toString().split('.').last.toUpperCase(),
        baseUrl: url,
        validateStatus: (status) =>
            status != null && status >= 200 && status < 300,
      );

      await dio.fetch<dynamic>(options);
    } catch (e, s) {
      Logger().e(
        'Failed to ${method.toString().toUpperCase()} webhook to $url',
        error: e,
        stackTrace: s,
      );
    }
  }
}
