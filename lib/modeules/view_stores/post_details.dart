import 'package:chefaa/core/api_config/api_constants.dart';
import 'package:chefaa/di/get_it.dart';
import 'package:chefaa/modeules/User/auth/presentation/usr_bloc/get_post_detals_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shared/components/components.dart';
import '../../Shared/theme/cubit/theme_cubit.dart';
import '../User/auth/data/models/post_response.dart';
import '../User/auth/presentation/pages/signup_screen.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key, required this.id});
  final String id;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  late GetPostDetailsCubit getPostDetailsCubit;

  @override
  void initState() {
    getPostDetailsCubit = getIt();
    getPostDetailsCubit.getPostDetails(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    final String description =
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).";
    return BlocProvider<GetPostDetailsCubit>.value(
      value: getPostDetailsCubit,
      child: BlocBuilder<GetPostDetailsCubit, GetPostDetailsState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor:
                    theme.isDark ? Color(0xff303030) : Colors.white,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  'Chefaa',
                  style: TextStyle(color: Color(0xff089BAB)),
                ),
                actions: [
                  IconButton(
                    icon: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGVyc29uJTIwYXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60')),
                    onPressed: () {
                      navigateTo(
                        context,
                        UserSignUp(),
                      );
                    },
                  ),
                ],
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xff089BAB),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    // navigateTo(context, StoreDetails(pharmacyId: '',));
                  },
                ),
              ),
              body: BodyWidget());
        },
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPostDetailsCubit, GetPostDetailsState>(
      buildWhen: (previous, current) => !(current is PostLikeStet),
      builder: (context, state) {
        if (state is GetPostDetailsStateLoaded || state is PostLikeStet) {
          late Post post;
          if (state is GetPostDetailsStateLoaded) post = state.post;
          if (state is PostLikeStet) post = state.post;

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(getPhotoLink(post.photo!)),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<GetPostDetailsCubit>().likePost(post.id!);
                      },
                      child:
                          BlocBuilder<GetPostDetailsCubit, GetPostDetailsState>(
                        builder: (context, likeState) {
                          late Post post;
                          if (likeState is GetPostDetailsStateLoaded) {
                            post = likeState.post;
                          }

                          if (likeState is PostLikeStet) post = likeState.post;
                          return Icon(
                            Icons.thumb_up,
                            color: post.isLiked == true
                                ? Colors.purple
                                : Color(0xff089BAB),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.comment,
                      color: Color(0xff089BAB),
                    ),
                    SizedBox(
                      width: 200,
                    ),
                    Icon(
                      Icons.share,
                      color: Color(0xff089BAB),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'El Ezaby Pharmacy',
                    style: TextStyle(
                        color: Color(0xff089BAB),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                DescriptionTextWidget(text: post.description!)
              ],
            ),
          );
        }
        if (state is GetPostDetailsStateLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (state is GetPostDetailsStateError)
          return Center(
            child: Text(state.error.errorMessege),
          );
        return SizedBox();
      },
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 200) {
      firstHalf = widget.text.substring(0, 200);
      secondHalf = widget.text.substring(200, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : new Column(
              children: <Widget>[
                new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
                new InkWell(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        flag ? "...More" : "Show less",
                        style: new TextStyle(color: Color(0xff089BAB)),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
