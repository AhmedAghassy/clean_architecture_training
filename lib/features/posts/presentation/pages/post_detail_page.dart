import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';
import '../widgets/post_detail_page/delete_btn_widget.dart';
import '../widgets/post_detail_page/divider_post_detail_widget.dart';
import '../widgets/post_detail_page/edit_btn_widget.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(title: const Text('Post detail'));
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const DividerPostDetailWidget(),
              Text(
                post.body,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const DividerPostDetailWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EditBtnWidget(post: post),
                  DeleteBtnWidget(postId: post.id!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
