import 'package:uni_link/features/chat/data/data_sources/chat_remote_data_resource.dart';
import 'package:uni_link/features/chat/domain/entities/chat_entities.dart';
import 'package:uni_link/features/chat/domain/entities/message_entities.dart';
import 'package:uni_link/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> deleteChat(ChatEntity chat) async => remoteDataSource.deleteChat(chat);

  @override
  Future<void> deleteMessage(MessageEntity message) async => remoteDataSource.deleteMessage(message);
  @override
  Stream<List<MessageEntity>> getMessages(MessageEntity message) => remoteDataSource.getMessages(message);

  @override
  Stream<List<ChatEntity>> getMyChat(ChatEntity chat) => remoteDataSource.getMyChat(chat);
  @override
  Future<void> sendMessage(ChatEntity chat, MessageEntity message) async => remoteDataSource.sendMessage(chat, message);

  @override
  Future<void> seenMessageUpdate(MessageEntity message) async => remoteDataSource.seenMessageUpdate(message);

}