import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/constant/message_constant.dart';
import 'package:uni_link/features/chat/data/models/chat_model.dart';
import 'package:uni_link/features/chat/data/models/message_model.dart';
import 'package:uni_link/features/chat/domain/entities/chat_entities.dart';
import 'package:uni_link/features/chat/domain/entities/message_entities.dart';
import 'package:uuid/uuid.dart';

import 'chat_remote_data_resource.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore fireStore;

  ChatRemoteDataSourceImpl({required this.fireStore});


  @override
  Future<void> sendMessage(ChatEntity chat, MessageEntity message) async {

    await sendMessageBasedOnType(message);

    String recentTextMessage = "";

    switch (message.messageType) {
      case MessageTypeConst.photoMessage:
        recentTextMessage = '📷 Photo';
        break;
      case MessageTypeConst.videoMessage:
        recentTextMessage = '📸 Video';
        break;
      case MessageTypeConst.audioMessage:
        recentTextMessage = '🎵 Audio';
        break;
      case MessageTypeConst.gifMessage:
        recentTextMessage = 'GIF';
        break;
      default:
        recentTextMessage = message.message!;
    }


    await addToChat(ChatEntity(
      createdAt: chat.createdAt,
      senderProfile: chat.senderProfile,
      recipientProfile: chat.recipientProfile,
      recentTextMessage: recentTextMessage,
      recipientName: chat.recipientName,
      senderName: chat.senderName,
      recipientUid: chat.recipientUid,
      senderUid: chat.senderUid,
      totalUnReadMessages: chat.totalUnReadMessages,
    ));

  }

  Future<void> addToChat(ChatEntity chat) async {

    // users -> uid -> myChat -> uid -> messages -> messageIds

    final myChatRef = fireStore
        .collection(FirebaseConst.users)
        .doc(chat.senderUid)
        .collection(FirebaseConst.myChat);

    final otherChatRef = fireStore
        .collection(FirebaseConst.users)
        .doc(chat.recipientUid)
        .collection(FirebaseConst.myChat);

    final myNewChat = ChatModel(
      createdAt: chat.createdAt,
      senderProfile: chat.senderProfile,
      recipientProfile: chat.recipientProfile,
      recentTextMessage: chat.recentTextMessage,
      recipientName: chat.recipientName,
      senderName: chat.senderName,
      recipientUid: chat.recipientUid,
      senderUid: chat.senderUid,
      totalUnReadMessages: chat.totalUnReadMessages,
    ).toDocument();

    final otherNewChat = ChatModel(
        createdAt: chat.createdAt,
        senderProfile: chat.recipientProfile,
        recipientProfile: chat.senderProfile,
        recentTextMessage: chat.recentTextMessage,
        recipientName: chat.senderName,
        senderName: chat.recipientName,
        recipientUid: chat.senderUid,
        senderUid: chat.recipientUid,
        totalUnReadMessages: chat.totalUnReadMessages)
        .toDocument();

    try {
      myChatRef.doc(chat.recipientUid).get().then((myChatDoc) async {
        // Create
        if (!myChatDoc.exists) {
          await myChatRef.doc(chat.recipientUid).set(myNewChat);
          await otherChatRef.doc(chat.senderUid).set(otherNewChat);
          return;
        } else {
          // Update
          await myChatRef.doc(chat.recipientUid).update(myNewChat);
          await otherChatRef.doc(chat.senderUid).update(otherNewChat);
          return;
        }
      });
    } catch (e) {
      print("error occur while adding to chat");
    }
  }

  Future<void> sendMessageBasedOnType(MessageEntity message) async {

    // users -> uid -> myChat -> uid -> messages -> messageIds

    final myMessageRef = fireStore
        .collection(FirebaseConst.users)
        .doc(message.senderUid)
        .collection(FirebaseConst.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseConst.messages);

    final otherMessageRef = fireStore
        .collection(FirebaseConst.users)
        .doc(message.recipientUid)
        .collection(FirebaseConst.myChat)
        .doc(message.senderUid)
        .collection(FirebaseConst.messages);

    String messageId = const Uuid().v1();

    final newMessage = MessageModel(
        senderUid: message.senderUid,
        recipientUid: message.recipientUid,
        senderName: message.senderName,
        recipientName: message.recipientName,
        createdAt: message.createdAt,
        repliedTo: message.repliedTo,
        repliedMessage: message.repliedMessage,
        isSeen: message.isSeen,
        messageType: message.messageType,
        message: message.message,
        messageId: messageId,
        repliedMessageType: message.repliedMessageType)
        .toDocument();

    try {
      await myMessageRef.doc(messageId).set(newMessage);
      await otherMessageRef.doc(messageId).set(newMessage);
    } catch (e) {
      print("error occur while sending message");
    }

  }


  @override
  Future<void> deleteChat(ChatEntity chat) async {
    final chatRef = fireStore
        .collection(FirebaseConst.users)
        .doc(chat.senderUid)
        .collection(FirebaseConst.myChat)
        .doc(chat.recipientUid);

    try {

      await chatRef.delete();

    } catch (e) {
      print("error occur while deleting chat conversation $e");
    }

  }

  @override
  Future<void> deleteMessage(MessageEntity message) async {
    final messageRef = fireStore
        .collection(FirebaseConst.users)
        .doc(message.senderUid)
        .collection(FirebaseConst.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseConst.messages)
        .doc(message.messageId);

    try {

      await messageRef.delete();

    } catch (e) {
      print("error occur while deleting message $e");
    }
  }

  @override
  Stream<List<MessageEntity>> getMessages(MessageEntity message) {
    final messagesRef = fireStore
        .collection(FirebaseConst.users)
        .doc(message.senderUid)
        .collection(FirebaseConst.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseConst.messages)
        .orderBy("createdAt", descending: false);

    return messagesRef.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => MessageModel.fromSnapshot(e)).toList());

  }

  @override
  Stream<List<ChatEntity>> getMyChat(ChatEntity chat) {
    final myChatRef = fireStore
        .collection(FirebaseConst.users)
        .doc(chat.senderUid)
        .collection(FirebaseConst.myChat)
        .orderBy("createdAt", descending: true);

    return myChatRef
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((e) => ChatModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> seenMessageUpdate(MessageEntity message) async {
    final myMessagesRef = fireStore
        .collection(FirebaseConst.users)
        .doc(message.senderUid)
        .collection(FirebaseConst.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseConst.messages)
        .doc(message.messageId);

    final otherMessagesRef = fireStore
        .collection(FirebaseConst.users)
        .doc(message.recipientUid)
        .collection(FirebaseConst.myChat)
        .doc(message.senderUid)
        .collection(FirebaseConst.messages)
        .doc(message.messageId);

    await myMessagesRef.update({"isSeen": true});
    await otherMessagesRef.update({"isSeen": true});
  }


}