import 'package:bloc/bloc.dart';
import 'package:blog_apps/model/response_blog.dart';
import 'package:blog_apps/network/repository/api_repository.dart';
import 'package:blog_apps/network/service/api_service.dart';
import 'package:equatable/equatable.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final ApiRepository _repository = ApiService();

  BlogBloc() : super(BlogInitial()) {
    on<BlogEvent>((event, emit) async {
      if (event is GetBlog) {
        try {
          emit(BlogInitial());
          var data = await _repository.getBlog();

          emit(
            BlogLoaded(
              responseBlog: data,
            ),
          );
        } catch (e) {
          print(e);
          emit(
            BlogError(
              error: e.toString(),
            ),
          );
        }
      }
    });
  }
}
