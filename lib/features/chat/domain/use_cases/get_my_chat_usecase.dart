import 'package:uni_link/features/chat/domain/entities/chat_entities.dart';
import 'package:uni_link/features/chat/domain/repositories/chat_repository.dart';

class GetMyChatUseCase {

  final ChatRepository repository;

  GetMyChatUseCase({required this.repository});

  Stream<List<ChatEntity>> call(ChatEntity chat)  {
    return repository.getMyChat(chat);
  }
}