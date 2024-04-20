import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/constant/const.dart';

import 'package:uni_link/features/news/presentaion/managers/news/news_cubit.dart';
import 'package:uni_link/features/news/presentaion/pages/widget/single_news.dart';
import 'package:uni_link/injection_container.dart' as di;

import '../../domain/entities/news_entity.dart';

class NewsPage extends StatelessWidget {
  const  NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<NewsCubit>(
          create: (context) => di.sl<NewsCubit>()..getNews(news: NewsEntity()),
          child: BlocBuilder<NewsCubit, NewsState>(
            builder: (context, newsState) {
              if (newsState is NewsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (newsState is NewsFailure) {
                toast("Some Failure occured while creating the news");
              }
              if (newsState is NewsLoaded) {
                return newsState.news.isEmpty
                    ? _noNewsYetWidget()
                    : ListView.builder(
                        itemCount: newsState.news.length,
                        itemBuilder: (context, index) {
                          final news = newsState.news[index];
                          return BlocProvider(
                            create: (context) => di.sl<NewsCubit>(),
                            child: NewsWidget(news: news),

                          );
                        },
                      );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  _noNewsYetWidget() {
    return Center(
      child: Text(
        "No News Yet",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
