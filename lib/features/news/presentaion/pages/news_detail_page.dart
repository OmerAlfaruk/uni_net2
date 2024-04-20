import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/features/news/presentaion/managers/news/get_single_new/get_single_news_cubit.dart';
import 'package:uni_link/features/news/presentaion/managers/news/news_cubit.dart';
import 'package:uni_link/features/news/presentaion/pages/sub_widget/news_detail_page.dart';
import 'package:uni_link/injection_container.dart' as di;

class NewsDetailPage extends StatelessWidget {
  final String newsId;
  const NewsDetailPage({Key? key, required this.newsId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetSingleNewsCubit>(
          create: (context) => di.sl<GetSingleNewsCubit>(),
        ),
        BlocProvider<NewsCubit>(
          create: (context) => di.sl<NewsCubit>(),
        ),
      ],
      child: NewsDetailMainWidget(newsId: newsId),
    );
  }
}