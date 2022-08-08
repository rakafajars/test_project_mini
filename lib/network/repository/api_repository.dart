import 'package:blog_apps/model/response_blog.dart';

abstract class ApiRepository {
  Future<List<ResponseBlog>> getBlog();
}
