import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('---------------------------------------------------------');
    print('JW-REQUEST');
    print('---------------------------------------------------------');
    print('Request: ${options.method} ${options.path}');
    print('Headers: ${options.headers}');
    print('Data: ${options.data}');
    super.onRequest(options, handler);
    print('---------------------------------------------------------');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response: ${response.statusCode} ${response.statusMessage}');
    print('Content-Type: ${response.headers.value('content-type')}');
    print('Data: ${response.data}');
    super.onResponse(response, handler);
    print('---------------------------------------------------------');
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('Error: ${err.message}');
    if (err.response != null) {
      print('Error Data: ${err.response?.data}');
      print('Error Content-Type: ${err.response?.headers.value('content-type')}');
    }
    super.onError(err, handler);
    print('---------------------------------------------------------');
  }
}