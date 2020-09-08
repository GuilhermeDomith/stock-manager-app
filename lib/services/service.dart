import 'package:dio/dio.dart';
import 'package:stock_manager_app/config.dart';

class CustomService {
  final Dio api = Dio();

  CustomService(){
    this.api.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        var customHeaders = {
          'content-type': "application/json"
        };

        options.headers.addAll(customHeaders);
        options.baseUrl = Config.baseUrl;

        return options;
      },
    ));
  }
}