import 'package:blog_apps/bloc/blog/blog_bloc.dart';
import 'package:blog_apps/model/response_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/repository/api_repository.dart';
import '../network/service/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiRepository _repository = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Blog',
        ),
      ),
      body: BlocProvider<BlogBloc>(
        create: (context) => BlogBloc()
          ..add(
            GetBlog(),
          ),
        child: BlocBuilder<BlogBloc, BlogState>(
          builder: (context, state) {
            if (state is BlogInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is BlogLoaded) {
              List<ResponseBlog> _listBlog = state.responseBlog;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _listBlog.length,
                      itemBuilder: (context, int index) {
                        ResponseBlog _dataBlog = _listBlog[index];
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      _dataBlog.title
                                              ?.substring(0, 1)
                                              .toUpperCase() ??
                                          "-",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          _dataBlog.title ?? "-",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          _dataBlog.body
                                                  ?.replaceAll("\n", " ") ??
                                              "-",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 8),
                              Divider(
                                thickness: 1,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is BlogError) {
              return Center(
                child: Text(
                  state.error ?? "-",
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
