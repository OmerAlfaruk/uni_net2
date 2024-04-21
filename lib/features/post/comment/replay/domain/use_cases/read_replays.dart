
import 'package:uni_link/features/post/comment/replay/domain/entities/replay_entity.dart';
import 'package:uni_link/features/post/comment/replay/domain/repositories/replay_repository.dart';

class ReadReplaysUseCase {
  final ReplayRepository repository;

  ReadReplaysUseCase({required this.repository});

  Stream<List<ReplayEntity>> call(ReplayEntity replay) {
    return repository.readReplays(replay);
  }
}