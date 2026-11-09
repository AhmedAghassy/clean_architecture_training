import 'package:flutter/material.dart';

import '../../../domain/entities/post.dart';
import '../../pages/post_add_update_page.dart';

class EditBtnWidget extends StatelessWidget {
  final Post post;

  const EditBtnWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton.icon(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PostAddUpdatePage(isAddPost: false, post: post),
          ),
        ),
        label: const Text('Edit'),
        icon: const Icon(Icons.edit),
      ),
    );
  }
}
