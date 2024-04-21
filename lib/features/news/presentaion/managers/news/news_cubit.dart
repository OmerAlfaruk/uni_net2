import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:uni_link/features/news/domain/use_cases/create_news_usecase.dart';
import 'package:uni_link/features/news/domain/use_cases/delete_news_usecase.dart';
import 'package:uni_link/features/news/domain/use_cases/like_news_usecase.dart';
import 'package:uni_link/features/news/domain/use_cases/read_news_usecase.dart';
import 'package:uni_link/features/news/domain/use_cases/update_news_usecase.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final CreateNewsUseCase createNewsUseCase;
  final DeleteNewsUseCase deleteNewsUseCase;
  final LikeNewsUseCase likeNewsUseCase;
  final ReadNewsUseCase readNewsUseCase;
  final UpdateNewsUseCase updateNewsUseCase;
  NewsCubit({
    required this.updateNewsUseCase,
    required this.deleteNewsUseCase,
    required this.likeNewsUseCase,
    required this.createNewsUseCase,
    required this.readNewsUseCase
  }) : super(NewsInitial());

  Future<void> getNews({required NewsEntity news}) async {
    emit(NewsLoading());
    try {
      final streamResponse = readNewsUseCase.call(news);
      streamResponse.listen((news) {
        emit(NewsLoaded(news:news));
      });
    } on SocketException catch(_) {
      emit(NewsFailure());
    } catch (_) {
      emit(NewsFailure());
    }
  }

  Future<void> likeNews({required NewsEntity news}) async {
    try {
      await likeNewsUseCase.call(news);
    } on SocketException catch(_) {
      emit(NewsFailure());
    } catch (_) {
      emit(NewsFailure());
    }
  }

  Future<void> deleteNews({required NewsEntity news}) async {
    try {
      await deleteNewsUseCase.call(news);
    } on SocketException catch(_) {
      emit(NewsFailure());
    } catch (_) {
      emit(NewsFailure());
    }
  }

  Future<void> createNews({required NewsEntity news}) async {
    try {
      await createNewsUseCase.call(news);
    } on SocketException catch(_) {
      emit(NewsFailure());
    } catch (_) {
      emit(NewsFailure());
    }
  }

  Future<void> updateNews({required NewsEntity news}) async {
    try {
      await updateNewsUseCase.call(news);
    } on SocketException catch(_) {
      emit(NewsFailure());
    } catch (_) {
      emit(NewsFailure());
    }
  }}
