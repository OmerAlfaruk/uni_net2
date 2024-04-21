import 'package:uni_link/features/chat/domain/entities/message_entities.dart';
import 'package:uni_link/features/chat/domain/repositories/chat_repository.dart';

class DeleteMessageUseCase {

  final ChatRepository repository;

  DeleteMessageUseCase({required this.repository});

  Future<void> call(MessageEntity message) async {
    return await repository.deleteMessage(message);
  }
}