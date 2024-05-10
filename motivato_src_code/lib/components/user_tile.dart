import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;


  const UserTile ( 
    {
      super.key,
      required this.text,
      required this.onTap,
    }
  );


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
    ),
    margin : const EdgeInsets.symmetric( vertical: 5, horizontal: 25),
    padding: EdgeInsets.all(20),
    child : Row(
      children: [
      Image.asset(
      'images/coffee.png',
        width: 30, 
        height: 30, 
        ),
      Text(text),

    ],)
    ),
    );
  }}