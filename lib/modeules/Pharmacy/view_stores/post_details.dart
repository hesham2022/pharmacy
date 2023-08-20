
import 'package:chefaa/Shared/components/components.dart';
import 'package:chefaa/Shared/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_stores/store_details.dart';

class PharmacyPostDetails extends StatefulWidget {
  const PharmacyPostDetails({super.key});

  @override
  State<PharmacyPostDetails> createState() => _PharmacyPostDetailsState();
}

class _PharmacyPostDetailsState extends State<PharmacyPostDetails> {
  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    final String description =
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).";
    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.isDark ? Color(0xff303030) : Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Saydlety',
            style: TextStyle(color: Color(0xff089BAB)),
          ),
          actions: [
            IconButton(
              icon: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGVyc29uJTIwYXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60')),
              onPressed: () {

              },
            ),
          ],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xff089BAB),
            ),
            onPressed: () {
              navigateTo(context, StoreDetails(pharmacyId: '',));
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://mir-s3-cdn-cf.behance.net/project_modules/2800_opt_1/0db4f2157365945.6377637fc5ec8.png'),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.thumb_up,
                    color: Color(0xff089BAB),
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
              DescriptionTextWidget(text: description)
            ],
          ),
        ));
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
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? new Text(firstHalf,style: TextStyle(color:theme.isDark ? Colors.white : Colors.black, ),)
          : new Column(
              children: <Widget>[
                new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf),style: TextStyle(color:theme.isDark ? Colors.white : Colors.black, ),),
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
