import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Shared/components/components.dart';
import '../../../Shared/theme/cubit/theme_cubit.dart';
import '../../../core/api_config/api_constants.dart';
import '../../User/Messages_Screen/chat_cubit.dart';
import '../../User/auth/domain/entities/user.dart';
import '../../User/auth/presentation/blocs/auth_bloc/authentication_bloc.dart';
import 'avatar.dart';
import 'avatars.dart';
import 'chat_screen.dart';
import 'models/helpers.dart';
import 'models/message_data.dart';

class PharmacyMessagesScreen extends StatefulWidget {
  const PharmacyMessagesScreen({Key? key}) : super(key: key);

  @override
  State<PharmacyMessagesScreen> createState() => _PharmacyMessagesScreenState();
}

class _PharmacyMessagesScreenState extends State<PharmacyMessagesScreen> {
  @override
  void initState() {
    context.read<ChatCubit>().getChats();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);

    return Scaffold(
      backgroundColor: theme.isDark ? Color(0xff303030) : Colors.white,
      body: BlocBuilder<ChatCubit, ChatStat>(
        builder: (context, state) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: context.read<ChatCubit>().chatModels.length,
              itemBuilder: (context, index) {
                final _chat =
                    context.read<ChatCubit>().chatModels.toList()[index];
                User getOtherUser() {
                  return context.read<AuthenticationBloc>().state.user.isUser
                      ? _chat.pharmacy!
                      : _chat.user!;
                }

                return InkWell(
                  onTap: () {
                    print('object');
                    navigateTo(
                        context,
                        ChatScreen(
                            messageData: MessageData(
                                senderName: getOtherUser().isUser
                                    ? getOtherUser().name
                                    : getOtherUser().pharmacyName!,
                                message: 'message',
                                messageDate: DateTime.now(),
                                dateMessage: 'dateMessage',
                                profilePicture: getPhotoLink(
                                    getOtherUser().mainPhoto ?? '')),
                            user: context
                                    .read<AuthenticationBloc>()
                                    .state
                                    .user
                                    .isUser
                                ? _chat.pharmacy!
                                : _chat.user!));
                  },
                  child: _MessageTitle(
                    messageData: MessageData(
                      senderName:
                          context.read<AuthenticationBloc>().state.user.isUser
                              ? _chat.pharmacy!.pharmacyName!
                              : _chat.user!.name,
                      message: chat_list[index]['message'],
                      messageDate: DateTime.now(),
                      dateMessage: "10:21 pm",
                      profilePicture:
                          context.read<AuthenticationBloc>().state.user.isUser
                              ? getPhotoLink(_chat.pharmacy!.mainPhoto!)
                              : getPhotoLink(_chat.user!.mainPhoto ?? ''),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

Widget _delegate(BuildContext context, int index) {
  ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);

  final Faker faker = Faker();
  final date = Helpers.randomDate();
  return _MessageTitle(
    messageData: MessageData(
      senderName: chat_list[index]['name'],
      message: chat_list[index]['message'],
      messageDate: date,
      dateMessage: "10:21 pm",
      profilePicture: chat_list[index]['img'],
    ),
  );
}

class _MessageTitle extends StatelessWidget {
  const _MessageTitle({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MessageData messageData;
  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: theme.isDark ? Color(0xff303030) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AvatarC.medium(url: messageData.profilePicture),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      messageData.senderName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        letterSpacing: 0.2,
                        wordSpacing: 1.5,
                        fontWeight: FontWeight.w900,
                        color: theme.isDark ? Colors.white : Color(0xff303030),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(
                      messageData.message,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            theme.isDark ? Colors.grey[300] : Color(0xff303030),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    messageData.dateMessage.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: -0.2,
                      fontWeight: FontWeight.w600,
                      color: theme.isDark ? Colors.white : Color(0xff303030),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 18,
                    height: 18,
                    child: const Center(
                        child: FaIcon(
                      FontAwesomeIcons.checkDouble,
                      size: 14,
                      color: Color(0xff089bab),
                    )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
