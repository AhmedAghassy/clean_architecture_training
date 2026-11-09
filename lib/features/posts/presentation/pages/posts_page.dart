import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../bloc/posts/posts_bloc.dart';
import '../widgets/posts_page/error_message_posts_widget.dart';
import '../widgets/posts_page/posts_list_widget.dart';
import 'post_add_update_page.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(title: const Text('Posts'));
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (contextBlocBuilder, state) {
            if (state is LoadingState) {
              return const LoadingWidget();
            } else if (state is LoadedState) {
              return RefreshIndicator(
                onRefresh: () => _onRefresh(contextBlocBuilder),
                child: PostsListWidget(posts: state.posts),
              );
            } else if (state is ErrorState) {
              return ErrorMessagePostsWidget(errorMessage: state.errorMessage);
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const PostAddUpdatePage(isAddPost: true),
        ),
      ),
      child: const Icon(Icons.add),
    );
  }
}
