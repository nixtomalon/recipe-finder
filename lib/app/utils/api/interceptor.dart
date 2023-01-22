import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiInterceptor extends Interceptor {
  Logger logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    logger.d(response.statusCode);
    logger.d(response.data);
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, handler) {
    logger.d(err);
    logger.d(err.message);
    logger.d(err.response);
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions opt, handler) async {
    logger.d(opt.uri);
    logger.d(opt.data.toString());

    return super.onRequest(opt, handler);
  }
}
