
import 'package:uni_link/features/chat/domain/entities/message_entities.dart';
import 'package:uni_link/features/chat/domain/repositories/chat_repository.dart';

class SeenMessageUpdateUseCase {

  final ChatRepository repository;

  SeenMessageUpdateUseCase({required this.repository});

  Future<void> call(MessageEntity message) async {
    return await repository.seenMessageUpdate(message);
  }
}