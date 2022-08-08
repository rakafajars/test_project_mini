import 'package:blog_apps/bloc/blog/blog_bloc.dart';
import 'package:blog_apps/model/response_blog.dart';
import 'package:blog_apps/ui/home/detail_page.dart';
import 'package:blog_apps/ui/home/widget/item_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                        return ItemBlog(
                          dataBlog: _dataBlog,
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
