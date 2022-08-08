import 'package:blog_apps/model/response_blog.dart';
import 'package:blog_apps/network/dio_client.dart';
import 'package:blog_apps/network/repository/api_repository.dart';
import 'package:dio/dio.dart';

class ApiService implements ApiRepository {
  Dio get dio => dioClient();

  @override
  Future<List<ResponseBlog>> getBlog() async {
    try {
      final response = await dio.get(
        "https://jsonplaceholder.typicode.com/posts",
      );

      List<ResponseBlog> listBlog = [];
      List<dynamic> values = [];
      values = response.data;

      for (var i = 0; i < values.length; i++) {
        Map<String, dynamic> map = values[i];
        listBlog.add(ResponseBlog.fromJson(map));
      }

      return listBlog;
    } on DioError catch (e) {
      throw e.error;
    }
  }
}
