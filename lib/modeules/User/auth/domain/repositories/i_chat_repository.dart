// ignore: one_member_abstracts
import 'package:chefaa/modeules/User/Messages_Screen/message_request.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/api_errors/network_exceptions.dart';
import '../../../Messages_Screen/chat_mode.dart';
import '../../../Messages_Screen/chat_response.dart';
import '../../../Messages_Screen/upload_message_media_reposne.dart';
import '../entities/create_chat_params.dart';

// ignore: one_member_abstracts
abstract class IChatRespository {
  Future<Either<NetworkExceptions, ChatModel>> createChat(
    CreateChatParams params,
  );
  Future<Either<NetworkExceptions, ChatsResponse>> getChats();
  Future<Either<NetworkExceptions, UploadMediaResponse>> uploadMessage(
    MessageRequest params,
  );
}
