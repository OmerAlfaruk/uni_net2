import 'package:uni_link/features/chat/domain/entities/chat_entities.dart';
import 'package:uni_link/features/chat/domain/entities/message_entities.dart';

abstract class ChatRemoteDataSource {

  Future<void> sendMessage(ChatEntity chat, MessageEntity message);
  Stream<List<ChatEntity>> getMyChat(ChatEntity chat);
  Stream<List<MessageEntity>> getMessages(MessageEntity message);
  Future<void> deleteMessage(MessageEntity message);
  Future<void> seenMessageUpdate(MessageEntity message);

  Future<void> deleteChat(ChatEntity chat);
}