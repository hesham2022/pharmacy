import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

const List review_list = [
  {
    "name": "Ahmed Hamdy",
    "date": "4/12/2022",
    "rate": "4.9",
    "comment": "Very Good Pharmacy , Excllent Services ❤",
  },
  {
    "name": "Yassin Mohamed",
    "date": "25/11/2022",
    "rate": "4.9",
    "comment": "Best Pharmacy in our area fr 👍",
  },
  {
    "name": "Ahmed Hesham",
    "date": "05/11/2022",
    "rate": "4.8",
    "comment": "Not bad , sometimes they late 🤷‍♂️",
  },
  {
    "name": "Salma Essam",
    "date": "02/11/2022",
    "rate": "4.6",
    "comment": "Good services ",
  },
  {
    "name": "Yehia Hany",
    "date": "01/11/2022 ",
    "rate": "4.8",
    "comment": "they got great sales 🤑",
  },
  {
    "name": "Youssef Nasser",
    "date": "31/10/2022",
    "rate": "4.7",
    "comment": "they got at the exact time 😎",
  },
  {
    "name": "Fati",
    "date": "22/10/2022",
    "rate": "4.9",
    "comment": "Great",
  },
];

const kPrimaryColor = Color(0xFFFF8084);
const kAccentColor = Color(0xFFF1F1F1);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFF808080);
const kDarkColor = Color(0xFF303030);
const kTransparent = Colors.transparent;

class ReviewUI extends StatelessWidget {
  final String image, name, date, comment;
  final double rating;
  final Function onTap, onPressed;
  final bool isLess;
  const ReviewUI({
    Key? key,
    required this.image,
    required this.name,
    required this.date,
    required this.comment,
    required this.rating,
    required this.onTap,
    required this.isLess,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 2.0,
        bottom: 2.0,
        left: 16.0,
        right: 0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 45.0,
                width: 45.0,
                margin: EdgeInsets.only(right: 16.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(44.0),
                ),
              ),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              SmoothStarRating(
                starCount: 5,
                rating: rating,
                size: 28.0,
                color: Colors.orange,
                borderColor: Colors.orange,
              ),
              SizedBox(width: 20),
              Text(
                date,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: () {},
            child: isLess
                ? Text(
                    comment,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: kLightColor,
                    ),
                  )
                : Text(
                    comment,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: kLightColor,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
