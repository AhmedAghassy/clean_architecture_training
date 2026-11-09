import 'package:flutter/material.dart';

import '../../../../../core/theme/theme.dart';
import '../../../domain/entities/post.dart';
import '../../pages/post_detail_page.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostsListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (contextListViewBuilder, index) => ListTile(
        leading: Text(
          posts[index].id.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            posts[index].title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        subtitle: Text(
          posts[index].body,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PostDetailPage(post: posts[index])),
        ),
      ),
      separatorBuilder: (contextListViewSeparator, index) => const Divider(
        thickness: 1,
        color: primaryClr,
        indent: 10,
        endIndent: 10,
      ),
      itemCount: posts.length,
    );
  }
}
