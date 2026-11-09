import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/snackbar_message_util.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/post.dart';
import '../bloc/posts_modify/posts_modify_bloc.dart';
import '../widgets/post_add_update_page/add_update_form_widget.dart';
import 'posts_page.dart';

class PostAddUpdatePage extends StatelessWidget {
  final bool isAddPost;
  final Post? post;

  const PostAddUpdatePage({super.key, required this.isAddPost, this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text(isAddPost ? 'Add post' : 'Edit post'));
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<PostsModifyBloc, PostsModifyState>(
          builder: (contextBlocBuilder, state) {
            if (state is LoadingAddOrDeleteOrUpdateStateState) {
              return const LoadingWidget();
            }
            return AddUpdateFormWidget(isAddPost: isAddPost, post: post);
          },
          listener: (contextBLocListener, state) {
            if (state is SuccessAddOrDeleteOrUpdateState) {
              SnackBarMessageUtil.show(
                contextBLocListener,
                message: state.successMessage,
                isSuccessMessage: true,
              );
              Navigator.pushAndRemoveUntil(
                contextBLocListener,
                MaterialPageRoute(builder: (_) => const PostsPage()),
                (_) => false,
              );
            } else if (state is ErrorAddOrDeleteOrUpdateState) {
              SnackBarMessageUtil.show(
                contextBLocListener,
                message: state.errorMessage,
                isSuccessMessage: false,
              );
            }
          },
        ),
      ),
    );
  }
}
