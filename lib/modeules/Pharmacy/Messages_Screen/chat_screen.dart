import 'dart:io';

import 'package:chefaa/Shared/icons.dart';
import 'package:chefaa/core/api_config/index.dart';
import 'package:chefaa/di/get_it.dart';
import 'package:chefaa/modeules/User/Messages_Screen/chat_cubit.dart';
import 'package:chefaa/modeules/User/Messages_Screen/chat_mode.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/user.dart';
import 'package:chefaa/modeules/User/auth/presentation/blocs/auth_bloc/authentication_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../Shared/theme/cubit/theme_cubit.dart';
import '../../User/Messages_Screen/message_request.dart';
import '../../User/auth/domain/entities/create_chat_params.dart';
import '../../User/auth/domain/usecases/get_near.dart';
import 'models/message_data.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.messageData, required this.user})
      : super(key: key);

  final MessageData messageData;
  final User user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  CreateChatParams getParams() {
    final u = context.read<AuthenticationBloc>().state.user;
    if (u.isUser) {
      return CreateChatParams(pharmacy: widget.user.id, user: u.id);
    } else {
      return CreateChatParams(user: widget.user.id, pharmacy: u.id);
    }
  }

  @override
  void initState() {
    context.read<ChatCubit>().createChat(getParams());

    super.initState();
  }

  ChatModel getChat(BuildContext context) {
    final chat =
        ((context.read<ChatCubit>().chatModels.toList().lastWhere((element) {
      return element.user!.id ==
              context.read<AuthenticationBloc>().state.user.id ||
          element.pharmacy!.id ==
              context.read<AuthenticationBloc>().state.user.id;
    })));

    return chat;
  }

  String? _imagrFile;
  String? _audioFile;
  String? _videoFile;
  TextEditingController controller = TextEditingController();

  Future<String?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imagrFile = pickedFile!.path;
    });
    return _imagrFile;
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<ChatCubit>().chatModels.toList().isNotEmpty)
      getChat(context);

    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);
    return BlocBuilder<ChatCubit, ChatStat>(
      builder: (context, state) {
        if (state is ChatStatLoaded &&
            context.read<ChatCubit>().chatModels.toList().isNotEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: _AppBarTitle(
                name: widget.user.isUser
                    ? widget.user.name
                    : widget.user.pharmacyName!,
                photo: getPhotoLink(widget.user.mainPhoto ?? ''),
              ), //63fe1b62d9d33acb5303a6f3
            ),
            body: Column(
              children: [
                Expanded(
                  child: _DemoMessageList(
                    chatModel: getChat(context),
                  ),
                ),
                if (_imagrFile != null)
                  Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Image.file(File(_imagrFile!))),
                _ActionBar(
                  controller: controller,
                  getImage: pickImage,
                  reciever: widget.user.id,
                  chatId: getChat(context).id!,
                  pickImage: () async {
                    await pickImage();
                  },
                  sendMessage: () async {
                    if (_imagrFile != null) {
                      final UploadMessageMedia uploadedFile =
                          getIt<UploadMessageMedia>();
                      final reuslt = await uploadedFile(MessageRequest(
                        mediaType: 'image',
                        file: _imagrFile,
                      ));
                      reuslt.fold((l) => null, (r) {
                        context.read<ChatCubit>().addNewMessageFromMe(
                            context.read<AuthenticationBloc>().state.user.id,
                            widget.user.id,
                            controller.text,
                            context.read<Socket>(),
                            User.getUser(context).role,
                            getChat(context).id!,
                            mediaType: r.mediaType,
                            mediaUrl: r.mediaUrl,
                            mediaDuration: r.mediaDuration,
                            mediaSize: r.mediaSize,
                            mediaName: r.mediaId);

                        setState(() {
                          _imagrFile = null;
                          controller.clear();
                        });
                      });

                      return;
                    }
                    context.read<ChatCubit>().addNewMessageFromMe(
                        context.read<AuthenticationBloc>().state.user.id,
                        widget.user.id,
                        controller.text,
                        context.read<Socket>(),
                        User.getUser(context).role,
                        getChat(context).id!);
                    controller.clear();
                  },
                ),
              ],
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class _DemoMessageList extends StatefulWidget {
  const _DemoMessageList({Key? key, required this.chatModel}) : super(key: key);
  final ChatModel chatModel;

  @override
  State<_DemoMessageList> createState() => _DemoMessageListState();
}

class _DemoMessageListState extends State<_DemoMessageList> {
  final controller = ScrollController();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    });

    super.initState();
  }

  String formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inDays > 0) {
      return DateFormat('dd MMM, yyyy').format(time);
    } else if (diff.inHours > 0) {
      return DateFormat('hh:mm a').format(time);
    } else {
      return DateFormat('hh:mm a').format(time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: BlocListener<ChatCubit, ChatStat>(
        listener: (context, state) {
          controller.animateTo(
            controller.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
          );
        },
        child: ListView(
          controller: controller,
          children: [
            // _DateLable(lable: '15 Jun,2022'),
            ...widget.chatModel.messages.reversed
                .map((e) => _MessageTile(
                    data: e,
                    message: e.text!,
                    messageDate: formatTime(e.time) //'12:01 PM',
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({
    Key? key,
    required this.message,
    required this.messageDate,
    required this.data,
  }) : super(key: key);

  final String message;
  final String messageDate;
  final Messages data;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  color: theme.isDark ? Color(0xff008897) : Color(0xff008897),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(_borderRadius),
                    topRight: Radius.circular(_borderRadius),
                    bottomRight: Radius.circular(_borderRadius),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 20),
                  child: Text(
                    message,
                    style: TextStyle(
                        color: theme.isDark ? Colors.white : Colors.white),
                  ),
                ),
              ),
            if (data.mediaUrl != null &&
                data.mediaUrl!.isNotEmpty &&
                data.mediaType == 'image')
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Column(
                        children: [
                          AppBar(
                            elevation: 0,
                          ),
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height - 100,
                              width: MediaQuery.of(context).size.width,
                              child: PhotoView(
                                imageProvider: NetworkImage(data.mediaUrl!),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.isDark ? Color(0xff008897) : Color(0xff008897),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(_borderRadius),
                      topRight: Radius.circular(_borderRadius),
                      bottomRight: Radius.circular(_borderRadius),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(data.mediaUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 150,
                  width: 150,
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: TextStyle(
                  color: theme.isDark ? Colors.grey : Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile({
    Key? key,
    required this.message,
    required this.messageDate,
  }) : super(key: key);

  final String message;
  final String messageDate;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.isDark ? Color(0xffceebee) : Color(0xffceebee),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message,
                    style: TextStyle(
                      color: theme.isDark ? Color(0xff303030) : Colors.black,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: TextStyle(
                  color: theme.isDark ? Colors.grey : Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DateLable extends StatelessWidget {
  const _DateLable({
    Key? key,
    required this.lable,
  }) : super(key: key);

  final String lable;
  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          decoration: BoxDecoration(
            color: theme.isDark ? Color(0xffcce7ea) : Color(0xffcce7ea),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              lable,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: theme.isDark ? Color(0xff303030) : Color(0xff303030),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    Key? key,
    required this.photo,
    required this.name,
  }) : super(key: key);

  final String photo;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: Image.network(photo),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 2),
              const Text(
                'Online now',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _ActionBar extends StatefulWidget {
  _ActionBar(
      {required this.getImage,
      Key? key,
      required this.chatId,
      required this.controller,
      required this.sendMessage,
      required this.pickImage,
      required this.reciever})
      : super(key: key);
  final String chatId;
  final String reciever;
  final TextEditingController controller;
  final void Function() sendMessage;
  final void Function() pickImage;

  // pick file from gallery
  final Future<String?> Function() getImage;
  @override
  State<_ActionBar> createState() => _ActionBarState();
}

class _ActionBarState extends State<_ActionBar> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 2,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: widget.pickImage,
                      icon: Icon(
                        IconBroken.Image,
                        color: Color(0xff089bab),
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    IconBroken.Voice,
                    color: Color(0xff089bab),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: TextField(
                controller: widget.controller,
                style: TextStyle(
                    color: theme.isDark ? Colors.white : Colors.black,
                    fontSize: 14),
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: theme.isDark ? Colors.grey : Color(0xff303030)),
                  hintText: 'Type something...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 24.0,
            ),
            child: IconButton(
              color: Color(0xff089bab),
              icon: Icon(IconBroken.Send),
              onPressed: widget.sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
