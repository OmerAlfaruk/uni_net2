import 'package:uni_link/features/post/comment/replay/domain/entities/replay_entity.dart';
import 'package:uni_link/features/post/comment/replay/domain/repositories/replay_repository.dart';


class LikeReplayUseCase {
  final ReplayRepository repository;

  LikeReplayUseCase({required this.repository});

  Future<void> call(ReplayEntity replay) {
    return repository.likeReplay(replay);
  }
}