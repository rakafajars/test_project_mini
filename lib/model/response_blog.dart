import 'dart:convert';

List<ResponseBlog> responseBlogFromJson(String str) => List<ResponseBlog>.from(
    json.decode(str).map((x) => ResponseBlog.fromJson(x)));

class ResponseBlog {
  ResponseBlog({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  int? userId;
  int? id;
  String? title;
  String? body;

  factory ResponseBlog.fromJson(Map<String, dynamic> json) => ResponseBlog(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );
}
