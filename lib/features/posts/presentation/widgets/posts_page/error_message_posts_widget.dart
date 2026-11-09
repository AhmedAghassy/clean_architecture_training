import 'package:flutter/material.dart';

class ErrorMessagePostsWidget extends StatelessWidget {
  final String errorMessage;

  const ErrorMessagePostsWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: const TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }
}
