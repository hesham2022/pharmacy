import 'package:chefaa/Shared/components/components.dart';
import 'package:chefaa/modeules/Pharmacy/Messages_Screen/chat_screen.dart';
import 'package:chefaa/modeules/Pharmacy/Messages_Screen/models/message_data.dart';
import 'package:chefaa/modeules/User/auth/domain/entities/entities.dart';
import 'package:chefaa/modeules/User/auth/presentation/usr_bloc/get_reviews_cubit.dart';
import 'package:chefaa/modeules/view_stores/post_details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../Shared/icons.dart';
import '../../Shared/theme/cubit/theme_cubit.dart';
import '../../core/api_config/api_constants.dart';
import '../../di/get_it.dart';
import '../Pharmacy/Messages_Screen/models/helpers.dart';
import '../Pharmacy/view_stores/review_list.dart';
import '../User/auth/data/models/review_reponse.dart';
import '../User/auth/domain/entities/create_review_params.dart';
import '../User/auth/presentation/usr_bloc/create_review_cubit.dart';
import '../User/auth/presentation/usr_bloc/get_pharmacy_byuser_cubit.dart';
import '../User/auth/presentation/usr_bloc/get_posts_cubit.dart';
import '../User/auth/presentation/usr_bloc/get_review_stats_cubit.dart';

class StoreDetails extends StatefulWidget {
  const StoreDetails({Key? key, required this.pharmacyId}) : super(key: key);
  final String pharmacyId;
  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  late GetPharmacyByUserCubit cubit;
  late GetRatingStatsCubit getRatingStatsCubit;
  late GetReviewsCubit getReviewsCubit;
  late GetPostsCubit getPostsCubit;
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    cubit = getIt();
    getRatingStatsCubit = getIt();
    getReviewsCubit = getIt();
    getPostsCubit = getIt();

    cubit.getPharmacyByUser(widget.pharmacyId);
    controller.addListener(() {
      print('this');

      if (controller.position.atEdge) {
        if (controller.position.pixels != 0) {
          getPostsCubit.getPosts(widget.pharmacyId).then((value) {
            // Timer(Duration(milliseconds: 30), () {
            //   scrollController
            //       .jumpTo(scrollController.position.maxScrollExtent);
            // });
          });
        }
      }
    });
    super.initState();
  }

  var selected = 0;
  bool isMore = false;
  List<double> ratings = [0.1, 0.3, 0.5, 0.7, 0.9];
  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);

    var menu = ['posts'.tr(), 'reviews'.tr()];
    const icons = <IconData>[Icons.article, Icons.reviews];
    return BlocProvider<GetReviewsCubit>.value(
      value: getReviewsCubit,
      child: BlocProvider<GetPostsCubit>.value(
        value: getPostsCubit,
        child: BlocProvider<GetPharmacyByUserCubit>.value(
          value: cubit,
          child: BlocProvider<GetRatingStatsCubit>.value(
            value: getRatingStatsCubit,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor:
                    theme.isDark ? Color(0xff303030) : Colors.white,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  'Saydlety',
                  style: TextStyle(color: Color(0xff089BAB)),
                ),
                actions: [
                  BlocConsumer<GetPharmacyByUserCubit, GetPharmacyByUserState>(
                    listener: (context, state) {
                      if (state is GetPharmacyByUserStateError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error.errorMessege)));
                      }
                      // if (state is GetPharmacyByUserStateLoaded) {
                      //   getRatingStatsCubit.getStats(state.user.id);
                      // }
                    },
                    buildWhen: (previous, current) =>
                        current is GetPharmacyByUserStateLoaded,
                    builder: (context, state) {
                      if (state is GetPharmacyByUserStateLoaded)
                        return IconButton(
                          icon: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  getPhotoLink(state.user.mainPhoto!))),
                          onPressed: () {
                            Builder(builder: (context) {
                              return IconButton(
                                icon: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGVyc29uJTIwYXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60')),
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                              );
                            });
                          },
                        );

                      if (state is GetPharmacyByUserStateErrorFirstTime)
                        return Center(
                          child: Text(state.error.errorMessege),
                        );
                      return SizedBox();
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

                    // navigateTo(context, StoresScreen());
                  },
                ),
              ),
              body: SingleChildScrollView(
                controller: controller,
                child: Column(children: [
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: BlocConsumer<GetPharmacyByUserCubit,
                        GetPharmacyByUserState>(
                      listener: (context, state) {
                        if (state is GetPharmacyByUserStateError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.error.errorMessege)));
                        }
                        // if (state is GetPharmacyByUserStateLoaded) {
                        //   getRatingStatsCubit.getStats(state.user.id);
                        // }
                      },
                      buildWhen: (previous, current) =>
                          current is GetPharmacyByUserStateLoaded,
                      builder: (context, state) {
                        if (state is GetPharmacyByUserStateLoaded)
                          return MainDeailsWidget(user: state.user);

                        if (state is GetPharmacyByUserStateErrorFirstTime)
                          return Center(
                            child: Text(state.error.errorMessege),
                          );
                        return SizedBox();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    decoration: const BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(menu.length, (index) {
                        var name = menu[index];
                        var icon = icons[index];
                        return InkWell(
                          onTap: () {
                            selected = index;

                            setState(() {});
                          },
                          child: Container(
                            height: 200.0,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: const BoxDecoration(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      icon,
                                      color: selected == index
                                          ? Color(0xff089BAB)
                                          : Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: selected == index
                                                ? Color(0xff089BAB)
                                                : Colors.grey)),
                                  ],
                                ),
                                const Spacer(),
                                (selected == index)
                                    ? Container(
                                        height: 2.0,
                                        decoration: const BoxDecoration(
                                          color: Color(0xff089BAB),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              16.0,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Container(
                    height: 350.0,
                    margin: const EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IndexedStack(index: selected, children: [
                      PostSections(id: widget.pharmacyId),
                      ReviewsWidget(
                          theme: theme, ratings: ratings, id: widget.pharmacyId)
                    ]),
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainDeailsWidget extends StatelessWidget {
  const MainDeailsWidget({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(getPhotoLink(user.mainPhoto!)))),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Text(
                user.pharmacyName!,
                style: TextStyle(
                    color: Color(0xff089BAB),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Text((user.followCount ?? 0).toString()),
                Text(
                  'Followers',
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        // if (state is GetPharmacyByUserStateLoading)
        //   Center(
        //     child: CircularProgressIndicator(),
        //   )
        // else
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: () {
                if (user.isFollowed!)
                  context
                      .read<GetPharmacyByUserCubit>()
                      .unfollowPharmacy(user.id);
                else
                  context
                      .read<GetPharmacyByUserCubit>()
                      .followPharmacy(user.id);
              },
              child: Text(
                user.isFollowed! ? 'un-follow' : 'follow'.tr(),
                style: TextStyle(
                    color: !user.isFollowed! ? Colors.black : Colors.white,
                    fontSize: 12),
              ),
              color: !user.isFollowed! ? Color(0xffcce7ea) : Color(0xff089BAB),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              minWidth: 100,
            ),
            MaterialButton(
              onPressed: () {
                final data = Helpers.randomDate();

                navigateTo(
                    context,
                    ChatScreen(
                        messageData: MessageData(
                          senderName: 'ss',
                          message: 'messege',
                          profilePicture: 'assets/profile.jpg',
                          dateMessage: '23,23,2201',
                          messageDate: DateTime.now(),
                        ),
                        user: user));
              },
              child: Text(
                'msg'.tr(),
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              color: Color(0xffcce7ea),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              minWidth: 100,
            ),
            MaterialButton(
              onPressed: () {},
              child: Text(
                'contact'.tr(),
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              color: Color(0xffcce7ea),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              minWidth: 100,
            ),
          ],
        ),
        SizedBox(
          height: 15,
          width: 15,
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Icon(
                IconBroken.Location,
                color: Color(0xff089BAB),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                user.address!.governorate + '/' + user.address!.region,
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (user.hours24 != null && user.hours24 == true)
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(
                  IconBroken.Time_Circle,
                  color: Color(0xff089BAB),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'work24'.tr(),
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
      ],
    );
  }
}

class PostSections extends StatefulWidget {
  const PostSections({super.key, required this.id});
  final String id;
  @override
  State<PostSections> createState() => _PostSectionsState();
}

class _PostSectionsState extends State<PostSections> {
  late ScrollController controller;
  @override
  void initState() {
    context.read<GetPostsCubit>().getPosts(widget.id);
    controller = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Container(
          decoration: const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<GetPostsCubit, GetPostsState>(
              builder: (context, state) {
                if (state.posts.isEmpty)
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          // child: Text('noPosts'.tr()),
                          child: Text('No posts '),
                        ),
                      ],
                    ),
                  );
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.posts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    final post = state.posts[index];
                    return InkWell(
                      onTap: () {
                        navigateTo(context, PostDetails(id: post.id!));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image:
                                    NetworkImage(getPhotoLink(post.photo!)))),
                      ),
                    );
                  },
                );
              },
            ),
          )),
    );
  }
}

class ReviewsWidget extends StatefulWidget {
  const ReviewsWidget(
      {super.key,
      required this.theme,
      required this.ratings,
      required this.id});

  final ThemeCubit theme;
  final List<double> ratings;
  final String id;

  @override
  State<ReviewsWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends State<ReviewsWidget> {
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<GetReviewsCubit>(context)
              .getReviews(widget.id)
              .then((value) {
            // Timer(Duration(milliseconds: 30), () {
            //   scrollController
            //       .jumpTo(scrollController.position.maxScrollExtent);
            // });
          });
        }
      }
    });
  }

  void listenToNewReview(GetReviewsState state) {
    if (state is GetReviewsAtFirst) {
      reviews.insert(0, state.review);
    }
  }

  @override
  void initState() {
    context.read<GetRatingStatsCubit>().getStats(widget.id);
    context.read<GetReviewsCubit>().getReviews(widget.id);
    setupScrollController(context);
    context.read<GetReviewsCubit>().stream.listen(listenToNewReview);

    // setupScrollController(context);
    super.initState();
  }

  List<Review> reviews = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPharmacyByUserCubit, GetPharmacyByUserState>(
      builder: (context, state) {
        if (state is GetPharmacyByUserStateLoaded) {
          final user = state.user;
          return BlocBuilder<GetRatingStatsCubit, GetRatingStatsState>(
            builder: (context, state) {
              if (state is GetRatingLoaded)
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => RatingDialouge(
                                        pharmacyId: user.id,
                                        onDone: (review) {
                                          context
                                              .read<GetReviewsCubit>()
                                              .addReviewAtFirsy(review);
                                          Navigator.pop(context);
                                        },
                                      ));
                            },
                            child: Text('Add Your Review')),
                      ),
                      SizedBox(height: 25),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: widget.theme.isDark
                              ? Color.fromARGB(255, 23, 23, 23)
                              : Colors.grey[200],
                        ),
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: user.ratingsAverage.toString(),
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            color: widget.theme.isDark
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      TextSpan(
                                        text: "/5",
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          color: kLightColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SmoothStarRating(
                                  starCount: 5,
                                  rating: user.ratingsAverage!,
                                  size: 28.0,
                                  color: Color(0xfff6b921),
                                  borderColor: Color(0xfff6b921),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  "Reviews : ${user.ratingsQuantity}",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: kLightColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: 150.0,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                reverse: true,
                                itemCount: state.ratingStats.length,
                                itemBuilder: (context, index) {
                                  final status = state.ratingStats[index];
                                  print((user.ratingsQuantity!));
                                  return Row(
                                    children: [
                                      Text(
                                        "${status.id}",
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      SizedBox(width: 1.0),
                                      Icon(Icons.star,
                                          color: Color(0xfff6b921)),
                                      SizedBox(width: 8.0),
                                      LinearPercentIndicator(
                                        lineHeight: 6.0,
                                        // linearStrokeCap: LinearStrokeCap.roundAll,
                                        width: 100,
                                        animation: true,
                                        animationDuration: 2500,
                                        percent:
                                            ((status.number!.toDouble() * 100) /
                                                    user.ratingsQuantity!) /
                                                100,
                                        progressColor: Color(0xfff6b921),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: widget.theme.isDark
                                ? Color.fromARGB(255, 23, 23, 23)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8)),
                        child: BlocBuilder<GetReviewsCubit, GetReviewsState>(
                          builder: (context, state) {
                            if (state is GetReviewsLoading &&
                                context.read<GetReviewsCubit>().page == 1)
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            if (state is GetReviewsError)
                              return Center(
                                child: Text(state.error.errorMessege),
                              );
                            if (state is GetReviewsLoaded) {
                              reviews.addAll(state.reviews
                                  .where((element) => element.user != null));
                            }

                            return ListView.separated(
                              // controller: scrollController,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: (state is GetReviewsLoading)
                                  ? reviews.length + 1
                                  : reviews.length,
                              itemBuilder: (contex, index) {
                                if (index < reviews.length) {
                                  final review = reviews[index];

                                  return Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SmoothStarRating(
                                                spacing: 0.5,
                                                starCount: 5,
                                                rating:
                                                    review.rating!.toDouble(),
                                                size: 15.0,
                                                color: Color(0xfff6b921),
                                                borderColor: Color(0xfff6b921),
                                              ),
                                              Text(
                                                DateFormat.yMEd()
                                                    .format(review.createdAt!),
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                review.review!,
                                                style: TextStyle(
                                                    color: widget.theme.isDark
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "By :",
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    review.user!.name ?? '',
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
// context.read<GetReviewsCubit>().getReviews(id);
                                  return Center(
                                    child: Column(
                                      children: [
                                        Text(reviews.length.toString()),
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                  );
                                }
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Container(
                                height: 15,
                                color: widget.theme.isDark
                                    ? Color(0xff303030)
                                    : Color.fromARGB(255, 255, 255, 255),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              return SizedBox();
            },
          );
        }
        return SizedBox();
      },
    );
  }
}

class RatingDialouge extends StatefulWidget {
  const RatingDialouge(
      {super.key, required this.onDone, required this.pharmacyId});
  final Function(
    Review review,
  ) onDone;
  final String pharmacyId;

  @override
  State<RatingDialouge> createState() => _RatingDialougeState();
}

class _RatingDialougeState extends State<RatingDialouge> {
  double rate = 3;
  TextEditingController controller = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateReviewCubit>.value(
      value: getIt(),
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        alignment: Alignment.center,
        child: Container(
          height: 260,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: controller,
                  maxLines: 2,
                  validator: (s) =>
                      s!.isEmpty ? 'please provide your review' : null,
                ),
                SizedBox(
                  height: 20,
                ),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    rate = rating;
                    print(rating);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: BlocConsumer<CreateReviewCubit, CreateReviewState>(
                    listener: (context, state) {
                      if (state is CreateReviewError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error.errorMessege)));
                      }
                      if (state is CreateReviewLoaded) {
                        widget.onDone(state.reviews);
                      }
                    },
                    builder: (context, state) {
                      if (state is CreateReviewLoading)
                        return Center(child: CircularProgressIndicator());
                      ;
                      return ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              context.read<CreateReviewCubit>().CreateReview(
                                  CreateReviewParams(
                                      rating: rate,
                                      review: controller.text,
                                      pharmacy: widget.pharmacyId));
                            }
                          },
                          child: Text('Add Your Review'));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
