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
    on<BlogEvent>(
      (event, emit) async {
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
            emit(
              BlogError(
                error: e.toString(),
              ),
            );
          }
        } else if (event is GetSearchBlog) {
          try {
            if (event.search.length > 3) {
              emit(BlogInitial());
              var data = await _repository.getBlog();
              List<ResponseBlog> _listResultSearch = [];
              _listResultSearch = data
                  .where((element) => (element.title ?? "")
                      .toLowerCase()
                      .contains(event.search))
                  .toList();

              if (_listResultSearch.isEmpty) {
                emit(BlogEmpty());
              } else {
                emit(
                  BlogLoaded(
                    responseBlog: _listResultSearch,
                  ),
                );
              }
            }
          } catch (e) {
            emit(
              BlogError(
                error: e.toString(),
              ),
            );
          }
        }
      },
    );
  }
}
