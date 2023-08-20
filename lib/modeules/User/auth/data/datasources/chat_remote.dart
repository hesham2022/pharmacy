import 'package:chefaa/modeules/User/Messages_Screen/message_request.dart';

import '../../../../../core/api_config/api_client.dart';
import '../../../../../core/api_config/api_constants.dart';
import '../../../Messages_Screen/chat_mode.dart';
import '../../../Messages_Screen/chat_response.dart';
import '../../../Messages_Screen/upload_message_media_reposne.dart';

const kChat = '$kBaseUrl/chat';
const kMessage = '$kBaseUrl/message';

abstract class IChatRemote {
  IChatRemote(this.apiConfig);
  final ApiClient apiConfig;

  // Future<ChatResponse> getChats();
  Future<ChatModel> createChat(Map<String, dynamic> body);
  Future<ChatsResponse> getChats(Map<String, dynamic> body);
  Future<UploadMediaResponse> uploadMessage(MessageRequest message);
}

class ChatRemote extends IChatRemote {
  ChatRemote(super.apiConfig);

  // @override
  // Future<ChatResponse> getChats() async {
  //   final response = await apiConfig.get(kChat);
  //   final data = response.data as Map<String, dynamic>;
  //   final packageResult = ChatResponse.fromJson(data);
  //   return packageResult;
  // }

  @override
  Future<ChatModel> createChat(Map<String, dynamic> body) async {
    final response = await apiConfig.post(kChat, body: body);
    final data = response.data as Map<String, dynamic>;
    final packageResult = ChatModel.fromJson(data);
    return packageResult;
  }

  @override
  Future<ChatsResponse> getChats(Map<String, dynamic> body) async {
    final response = await apiConfig.get(kChat);
    final data = response.data as Map<String, dynamic>;
    final packageResult = ChatsResponse.fromJson(data);
    return packageResult;
  }

  @override
  Future<UploadMediaResponse> uploadMessage(MessageRequest message) async {
    print('message.toUpload() ${await message.toUpload()}');
    final response =
        await apiConfig.postUpload(kMessage, body: await message.toUpload());
    final data = response.data as Map<String, dynamic>;
    final reuslt = UploadMediaResponse.fromJson(data);
    return reuslt;
  }
}
