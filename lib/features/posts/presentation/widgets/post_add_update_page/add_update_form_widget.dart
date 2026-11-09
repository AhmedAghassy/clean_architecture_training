import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post.dart';
import '../../bloc/posts_modify/posts_modify_bloc.dart';
import 'form_btn_widget.dart';
import 'text_form_field_widget.dart';

class AddUpdateFormWidget extends StatefulWidget {
  final bool isAddPost;
  final Post? post;

  const AddUpdateFormWidget({
    super.key,
    required this.isAddPost,
    required this.post,
  });

  @override
  State<AddUpdateFormWidget> createState() => _AddUpdateFormWidgetState();
}

class _AddUpdateFormWidgetState extends State<AddUpdateFormWidget> {
  @override
  void initState() {
    if (!widget.isAddPost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
              controller: _titleController,
              name: 'Title',
              multilines: false,
            ),
            TextFormFieldWidget(
              controller: _bodyController,
              name: 'Body',
              multilines: true,
            ),
            FormBtnWidget(
              isAddPost: widget.isAddPost,
              onPressed: _validateFormThenAddOrUpdatePost,
            ),
          ],
        ),
      ),
    );
  }

  void _validateFormThenAddOrUpdatePost() {
    if (_formKey.currentState?.validate() == true) {
      final Post post = Post(
        id: widget.isAddPost ? null : widget.post?.id,
        title: _titleController.text,
        body: _bodyController.text,
      );
      if (widget.isAddPost) {
        BlocProvider.of<PostsModifyBloc>(context).add(AddPostEvent(post: post));
      } else {
        BlocProvider.of<PostsModifyBloc>(
          context,
        ).add(UpdatePostEvent(post: post));
      }
    }
  }
}
