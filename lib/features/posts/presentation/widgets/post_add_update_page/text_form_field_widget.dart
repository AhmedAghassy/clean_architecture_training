import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final bool multilines;

  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.name,
    required this.multilines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: name,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? '$name can\'t be empty' : null,
        minLines: multilines ? 6 : 1,
        maxLines: multilines ? 6 : 1,
      ),
    );
  }
}
