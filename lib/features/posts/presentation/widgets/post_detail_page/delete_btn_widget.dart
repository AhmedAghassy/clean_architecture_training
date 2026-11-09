import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/theme.dart';
import '../../../../../core/util/snackbar_message_util.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../bloc/posts_modify/posts_modify_bloc.dart';
import '../../pages/posts_page.dart';
import 'delete_dialog_widget.dart';

class DeleteBtnWidget extends StatelessWidget {
  final int postId;

  const DeleteBtnWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton.icon(
        onPressed: () => _deleteDialog(context, postId),
        label: const Text('Delete'),
        icon: const Icon(Icons.delete),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(errorColor),
          foregroundColor: WidgetStateProperty.all(darkGreyClr),
        ),
      ),
    );
  }

  void _deleteDialog(BuildContext context, int postId) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocConsumer<PostsModifyBloc, PostsModifyState>(
          builder: (blocBuilderContext, state) {
            if (state is LoadingAddOrDeleteOrUpdateStateState) {
              return const AlertDialog(title: LoadingWidget());
            }
            return DeleteDialogWidget(postId: postId);
          },
          listener: (blocListenerContext, state) {
            if (state is SuccessAddOrDeleteOrUpdateState) {
              SnackBarMessageUtil.show(
                blocListenerContext,
                message: state.successMessage,
                isSuccessMessage: true,
              );
              Navigator.pushAndRemoveUntil(
                blocListenerContext,
                MaterialPageRoute(builder: (_) => const PostsPage()),
                (_) => false,
              );
            } else if (state is ErrorAddOrDeleteOrUpdateState) {
              SnackBarMessageUtil.show(
                blocListenerContext,
                message: state.errorMessage,
                isSuccessMessage: false,
              );
              Navigator.pop(dialogContext);
            }
          },
        );
      },
    );
  }
}
