part of 'blog_bloc.dart';

abstract class BlogEvent extends Equatable {
  const BlogEvent();
}

class GetBlog extends BlogEvent {
  @override
  List<Object?> get props => [];
}

class GetSearchBlog extends BlogEvent {
  final String search;

  const GetSearchBlog({required this.search});
  @override
  List<Object?> get props => [search];
}
