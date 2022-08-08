part of 'blog_bloc.dart';

abstract class BlogState extends Equatable {
  const BlogState();
}

class BlogInitial extends BlogState {
  @override
  List<Object?> get props => [];
}

class BlogLoaded extends BlogState {
  final List<ResponseBlog> responseBlog;

  const BlogLoaded({required this.responseBlog});
  @override
  List<Object?> get props => [responseBlog];
}

class BlogEmpty extends BlogState {
  @override
  List<Object?> get props => [];
}

class BlogError extends BlogState {
  final String? error;

  const BlogError({required this.error});

  @override
  List<Object?> get props => [error];
}
