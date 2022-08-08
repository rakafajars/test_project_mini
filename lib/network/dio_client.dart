import 'package:dio/dio.dart';

Dio dioClient() {
  final options = BaseOptions(
    connectTimeout: 120000,
    receiveTimeout: 120000,
    contentType: 'application/json',
  );

  var dio = Dio(options);

  return dio;
}
