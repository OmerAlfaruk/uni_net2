
import 'package:uni_link/features/news/comment/replay/domain/entities/replay_entity.dart';
import 'package:uni_link/features/news/comment/replay/domain/repositories/replay_repository.dart';


class ReadNewsReplaysUseCase {
  final NewsReplayRepository repository;

  ReadNewsReplaysUseCase({required this.repository});

  Stream<List<ReplayEntity2>> call(ReplayEntity2 replay) {
    return repository.readReplays(replay);
  }
}