import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/features/post/comment/domain/entities/comment_entity.dart';
import 'package:uni_link/features/post/comment/presentation/manager/comment/comment_cubit.dart';
import 'package:uni_link/features/post/comment/presentation/pages/comment/widgets/edit_comment_main_widget.dart';

import 'package:uni_link/injection_container.dart' as di;

class EditCommentPage extends StatelessWidget {
  final CommentEntity comment;

  const EditCommentPage({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentCubit>(
      create: (context) => di.sl<CommentCubit>(),
      child: EditCommentMainWidget(comment: comment),
    );
  }
}
