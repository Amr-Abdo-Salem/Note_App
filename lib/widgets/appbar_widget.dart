import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
      {super.key,
      required this.appBarTitle,
      required this.iconData,
      required this.onPress});
  final String appBarTitle;
  final IconData iconData;
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appBarTitle,
          style: const TextStyle(
            fontSize: 35,
          ),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: IconButton(
            icon: Icon(
              iconData,
              size: 30,
            ),
            onPressed: onPress,
          ),
        ),
      ],
    );
  }
}
