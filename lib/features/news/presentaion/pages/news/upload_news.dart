import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/features/news/presentaion/managers/news/news_cubit.dart';
import 'package:uni_link/features/news/presentaion/pages/news/widget/upload_news_main_widget.dart';

import 'package:uni_link/features/post/presentation/manager/post/post_cubit.dart';
import 'package:uni_link/features/post/presentation/pages/post/widget/upload_post_main_widget.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';
import 'package:uni_link/injection_container.dart' as di;

class UploadNewsPage extends StatelessWidget {
  final UserEntity currentUser;

  const UploadNewsPage({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsCubit>(
      create: (context) => di.sl<NewsCubit>(),
      child: UploadNewsMainWidget(currentUser: currentUser),
    );
  }
}