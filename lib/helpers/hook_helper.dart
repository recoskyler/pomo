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
    String? urls, [
    TriggerMethod? method = TriggerMethod.post,
  ]) async {
    if (urls == null || urls.isEmpty) {
      return;
    }

    final urlList = urls
        .split(',')
        .where((url) {
          if (url.isEmpty) {
            return false;
          }

          try {
            Uri.parse(url);
            return true;
          } catch (_) {
            return false;
          }
        })
        .map((e) => e.trim())
        .toList();

    for (final url in urlList) {
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
}
