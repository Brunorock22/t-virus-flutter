import 'package:dio/dio.dart';

import 'app_interceptor.dart';
import 'backend_routes.dart';

class Backend{


  Dio io;
  AppInterceptor interceptor;

  static Backend _backend;

  factory Backend.instance() {
    _backend ??= Backend._ctor();
    return _backend;
  }

  Backend._ctor(){

    io = Dio();
    interceptor = AppInterceptor();
    io.interceptors.add(interceptor);
    io.options.baseUrl = BackendRoutes.baseURL;
    io.options.connectTimeout = 5000; //5s
    io.options.receiveTimeout = 3000;

  }

}