import 'package:chefaa/modeules/User/Messages_Screen/chat_response.dart';
import 'package:chefaa/modeules/User/Messages_Screen/message_request.dart';
import 'package:chefaa/modeules/User/auth/data/datasources/chat_remote.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/api_errors/network_exceptions.dart';
import '../../../../../core/utils/catch_async.dart';
import '../../../Messages_Screen/chat_mode.dart';
import '../../../Messages_Screen/upload_message_media_reposne.dart';
import '../../domain/entities/create_chat_params.dart';
import '../../domain/repositories/i_chat_repository.dart';

class ChatRepository extends IChatRespository {
  ChatRepository(this.chatRemote);
  final IChatRemote chatRemote;

  @override
  @override
  Future<Either<NetworkExceptions, ChatModel>> createChat(
    CreateChatParams params,
  ) =>
      guardFuture<ChatModel>(
        () => chatRemote.createChat(params.toMap()),
      );

  @override
  Future<Either<NetworkExceptions, ChatsResponse>> getChats() {
    return guardFuture<ChatsResponse>(() => chatRemote.getChats({}));
  }

  @override
  Future<Either<NetworkExceptions, UploadMediaResponse>> uploadMessage(
      MessageRequest params) {
    return guardFuture<UploadMediaResponse>(() => chatRemote.uploadMessage(params));
  }
}
