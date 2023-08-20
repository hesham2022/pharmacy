import 'package:flutter/material.dart';

class AvatarC extends StatelessWidget {
  const AvatarC({
    Key? key,
    required this.url,
    required this.radius,
  }) : super(key: key);

  const AvatarC.small({
    Key? key,
    required this.url,
  })  : radius = 16,
        super(key: key);

  const AvatarC.medium({
    Key? key,
    required this.url,
  })  : radius = 22,
        super(key: key);

  const AvatarC.large({
    Key? key,
    required this.url,
  })  : radius = 44,
        super(key: key);

  final double radius;
  final String url;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(url),
      backgroundColor: Theme.of(context).cardColor,
    );
  }
}
