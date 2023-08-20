import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../di/get_it.dart';
import '../User/Messages_Screen/chat_mode.dart';
import '../User/auth/domain/entities/create_chat_params.dart';
import '../User/auth/domain/repositories/i_chat_repository.dart';

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
  final chatModels = <ChatModel>[];
  Future<void> createChat(CreateChatParams params) async {
    emit(ChatStatLoading());
    final result = await chatRespository.createChat(params);
    emit(ChatStatLoaded(const []));
    result.fold((l) => print(l.errorMessege), (r) {
      chatModels.add(r);
      addNewChat(r.id!, r.id!);
    });
  }

  Future<void> addNewChat(
    String id,
    String chatId,
  ) async {
    if (state is ChatStatLoaded) {
      final chats = (state as ChatStatLoaded).chats;

      if (!(state as ChatStatLoaded).chats.map((e) => e.id).contains(id)) {
        emit(ChatStatLoading());
        emit(ChatStatLoaded([Chat(id), ...chats]));
      }
    } else {
      emit(ChatStatLoaded([Chat(id)]));
    }
  }

  void addMessage(
    Messages msg,
  ) {
    if (state is ChatStatLoaded) {
      if (chatModels.map((e) => e.id).contains(msg.chat)) {
        final chatModel =
            chatModels.firstWhere((element) => element.id == msg.chat);

        chatModel.messages!.add(
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
    String chatId,
  ) {
    addNewChat(receiverId, chatId);

    socket.emit(
      'sendMessage',
      <String, dynamic>{
        'senderId': senderId,
        'senderType': senderType,
        'receiverId': receiverId,
        'text': msg,
        'chatId': chatId
      },
    );

    final chat =
        (state as ChatStatLoaded).chats.firstWhere((e) => e.id == receiverId);
    chat.msgs.add(Message(text: msg, isMe: true, time: DateTime.now()));

    final _chats = [...(state as ChatStatLoaded).chats];
    emit(ChatStatLoading());

    emit(ChatStatLoaded(_chats));
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
