import 'package:flutter/material.dart';

class FormBtnWidget extends StatelessWidget {
  final bool isAddPost;
  final void Function() onPressed;

  const FormBtnWidget({
    super.key,
    required this.isAddPost,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        label: Text(isAddPost ? 'Add' : 'Update'),
        icon: Icon(isAddPost ? Icons.add : Icons.edit),
      ),
    );
  }
}
