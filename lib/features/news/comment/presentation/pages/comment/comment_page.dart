import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/features/app/domain/entities/app_entity.dart';
import 'package:uni_link/features/news/comment/presentation/managers/comment_cubit.dart';
import 'package:uni_link/features/news/comment/presentation/pages/comment/widgets/comment_main_widget.dart';
import 'package:uni_link/features/news/presentaion/managers/news/get_single_new/get_single_news_cubit.dart';
import 'package:uni_link/features/news/presentaion/managers/news/get_single_new/get_single_news_cubit.dart';
import 'package:uni_link/features/post/presentation/manager/post/get_single_post/get_single_post_cubit.dart';
import 'package:uni_link/features/user/presentation/manager/user/user_cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:uni_link/injection_container.dart' as di;



class CommentPage extends StatelessWidget {
  final AppEntity appEntity;

  const CommentPage({Key? key, required this.appEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsCommentCubit>(
          create: (context) => di.sl<NewsCommentCubit>(),
        ),
        BlocProvider<GetSingleUserCubit>(
          create: (context) => di.sl<GetSingleUserCubit>(),
        ),
        BlocProvider<GetSingleNewsCubit>(
          create: (context) => di.sl<GetSingleNewsCubit>(),
        ),
      ],
      child: CommentMainWidget(appEntity: appEntity),
    );
  }
}
