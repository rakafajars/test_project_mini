import 'package:blog_apps/bloc/blog/blog_bloc.dart';
import 'package:blog_apps/model/response_blog.dart';
import 'package:blog_apps/ui/home/widget/item_blog.dart';
import 'package:blog_apps/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Controller
  final _searchBlogController = TextEditingController();

  /// bloc
  late BlogBloc _blogBloc;

  /// var
  bool _isClearIcon = false;

  /// function get API Blog

  void _refreshApiBlog() {
    _blogBloc.add(GetBlog());
  }

  @override
  void initState() {
    _blogBloc = BlocProvider.of<BlogBloc>(context);
    _refreshApiBlog();
    super.initState();
  }

  @override
  void dispose() {
    _searchBlogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Blog',
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextField(
              controller: _searchBlogController,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                suffixIcon: _isClearIcon == true
                    ? GestureDetector(
                        onTap: () {
                          _refreshApiBlog();
                          _searchBlogController.clear();
                          _isClearIcon = false;
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.clear,
                        ),
                      )
                    : const Icon(
                        Icons.search,
                        size: 16,
                      ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.colorF0F1FA,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      16,
                    ),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.colorFF3A44,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                ),
              ),
              onChanged: (val) {
                if (val.length > 3) {
                  _isClearIcon = true;
                } else {
                  _isClearIcon = false;
                  if (val.isEmpty) {
                    _refreshApiBlog();
                  }
                }
                _blogBloc.add(
                  GetSearchBlog(
                    search: val,
                  ),
                );
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 18),
          BlocBuilder<BlogBloc, BlogState>(
            builder: (context, state) {
              if (state is BlogInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is BlogLoaded) {
                List<ResponseBlog> _listBlog = state.responseBlog;
                return Expanded(
                  child: ListView.builder(
                    itemCount: _listBlog.length,
                    itemBuilder: (context, int index) {
                      ResponseBlog _dataBlog = _listBlog[index];
                      return ItemBlog(
                        dataBlog: _dataBlog,
                      );
                    },
                  ),
                );
              } else if (state is BlogEmpty) {
                return const Center(
                  child: Text(
                    'Data yang kamu cari tidak ada',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
        ],
      ),
    );
  }
}
