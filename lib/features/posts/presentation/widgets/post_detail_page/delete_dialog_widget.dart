import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/posts_modify/posts_modify_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;

  const DeleteDialogWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      actions: [
        TextButton(
          onPressed: () => BlocProvider.of<PostsModifyBloc>(
            context,
          ).add(DeletePostEvent(id: postId)),
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('No'),
        ),
      ],
    );
  }
}
