// ignore_for_file: empty_constructor_bodies

import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";


class ChatBub extends StatelessWidget {  @override
  final String message;
  final bool isCurrentUser;

  ChatBub ({
    super.key,
    required this.message,
    required this.isCurrentUser
  });
  

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
        color: isCurrentUser ? Colors.blue : Colors.grey.shade500,
        borderRadius: BorderRadius.circular(20)       
       ),
       padding: const EdgeInsets.all(16),
       margin: EdgeInsets.symmetric(vertical: 3, horizontal: 25),
       child: Text(
        message,
        style: const TextStyle(color: Colors.white),
       ),
    );
  }

}