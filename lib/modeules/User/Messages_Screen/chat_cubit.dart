import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../di/get_it.dart';
import '../auth/domain/entities/create_chat_params.dart';
import '../auth/domain/repositories/i_chat_repository.dart';
import 'chat_mode.dart';

class Chat extends Equatable {
  Chat(this.id);

  final String id;
  final List<Message> msgs = [];

  @override
  List<Object?> get props => [msgs];
}

class ChatStat extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatStatIntitial extends ChatStat {}

class ChatStatLoading extends ChatStat {}

class ChatStatLoaded extends ChatStat {
  ChatStatLoaded(this.chats);

  final List<Chat> chats;

  @override
  List<Object?> get props => [chats];
}

class ChatCubit extends Cubit<ChatStat> {
  ChatCubit() : super(ChatStatIntitial());
  final IChatRespository chatRespository = getIt();
  List<ChatModel> chatModels = [];
  Future<void> createChat(CreateChatParams params) async {
    emit(ChatStatLoading());
    final result = await chatRespository.createChat(params);
    emit(ChatStatLoaded([]));
    result.fold((l) => print(l.errorMessege), (r) {
      print(r.id);
      final index = chatModels.indexWhere((element) {
        return element.id == r.id;
      });
      if (index == -1) {
        chatModels.add(r);
      } else {
        chatModels[index] = r;
      }
      // chatModels.add(r);
      // addNewChat(r.id!, r.id!);
    });
  }

  Future<void> getChats() async {
    emit(ChatStatLoading());
    final result = await chatRespository.getChats();
    emit(ChatStatLoaded([]));
    result.fold((l) => print(l.errorMessege), (r) {
      chatModels = [...r.results];
    });
  }

  void addMessage(
    Messages msg,
  ) {
    if (state is ChatStatLoaded) {
      if (chatModels.map((e) => e.id).contains(msg.chat)) {
        final chatModel =
            chatModels.firstWhere((element) => element.id == msg.chat);

        chatModel.messages.insert(
          0,
          msg,
        );
      }

      final _chats = [...(state as ChatStatLoaded).chats];
      emit(ChatStatLoading());
      emit(ChatStatLoaded(_chats));
    }
  }

  void addNewMessageFromMe(
    String senderId,
    String receiverId,
    String msg,
    Socket socket,
    String senderType,
    String chatId, {
    String? mediaType,
    String? mediaUrl,
    int? mediaDuration,
    int? mediaSize,
    String? mediaName,
  }) {
    // addNewChat(receiverId, chatId);

    socket.emit(
      'sendMessage',
      <String, dynamic>{
        'senderId': senderId,
        'senderType': senderType,
        'receiverId': receiverId,
        'text': msg,
        'chatId': chatId,
        'mediaType': mediaType,
        'mediaUrl': mediaUrl,
        'mediaDuration': mediaDuration,
        'mediaSize': mediaSize,
        'mediaName': mediaName,
      },
    );

    final chat = chatModels.lastWhere((e) => e.id == chatId);
    print(chat.messages);
    chat.messages.insert(
        0,
        Messages.fromJson({
          'id': DateTime.now().toString(),
          'time': DateTime.now().toString(),
          'senderId': senderId,
          'senderType': senderType,
          'receiverId': receiverId,
          'text': msg,
          'chatId': chatId,
          'mediaType': mediaType,
          'mediaUrl': mediaUrl,
          'mediaDuration': mediaDuration,
          'mediaSize': mediaSize,
          'mediaName': mediaName,
        }));

    emit(ChatStatLoading());

    emit(ChatStatLoaded([]));
  }
}

class Message {
  Message({
    required this.text,
    required this.isMe,
    required this.time,
  });
  final String text;
  final bool isMe;
  final DateTime time;
}
