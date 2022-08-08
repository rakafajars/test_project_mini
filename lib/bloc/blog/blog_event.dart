part of 'blog_bloc.dart';

abstract class BlogEvent extends Equatable {
  const BlogEvent();
}

class GetBlog extends BlogEvent {
  @override
  List<Object?> get props => [];
}
