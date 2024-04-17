import 'package:uni_link/features/chat/domain/entities/chat_entities.dart';
import 'package:uni_link/features/chat/domain/entities/message_entities.dart';
import 'package:uni_link/features/chat/domain/repositories/chat_repository.dart';

class SendMessageUseCase {

  final ChatRepository repository;

  SendMessageUseCase({required this.repository});

  Future<void> call(ChatEntity chat, MessageEntity message) async {
    return await repository.sendMessage(chat, message);
  }
}