import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:uni_link/features/news/domain/use_cases/read_single_news_usecase.dart';

part 'get_single_news_state.dart';

class GetSingleNewsCubit extends Cubit<GetSingleNewsState> {
  final ReadSingleNewsUseCase readSingleNewsUseCase;
  GetSingleNewsCubit({required this.readSingleNewsUseCase}) : super(GetSingleNewsInitial());

  Future<void> getSingleNews({required String newsId}) async {
    emit(GetSingleNewsLoading());
    try {
      final streamResponse = readSingleNewsUseCase.call(newsId);
      streamResponse.listen((newss) {
        emit(GetSingleNewsLoaded(news:newss.first));
      });
    } on SocketException catch(_) {
      emit(GetSingleNewsFailure());
    } catch (_) {
      emit(GetSingleNewsFailure());
    }
  }
}
