// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motivato/components/user_tile.dart';
import 'package:motivato/pages/chat_page.dart';
import 'package:motivato/pages/home_page.dart';
import 'package:motivato/services/chat/chat_service.dart';
import"/services/auth/auth_service.dart";



class AllChatPage extends StatelessWidget {
  AllChatPage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatService.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Loading indicator
        }

        final users = snapshot.data ?? []; // Ensure users is not null

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final userData = users[index];
            if (userData["email"] != _auth.getCurrentUser()?.email) {
              return _buildUserListItem(userData, context);
            } else {
              return Container(); // Return an empty Container if the condition is not met
            }
          },
        );
      },
    );
  }

  Widget _buildUserListItem(
    Map<String, dynamic> userData, 
    BuildContext context,
  ) {
    final String? receiverEmail = userData["email"];
    final String? receiverID = userData["uid"];

    if (receiverEmail != null && receiverID != null) {
      return UserTile(
        text: receiverEmail,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                recieverEmail:  userData["email"], 
                recieverID: userData["uid"],
                
              ),
            ),
          );
        },
      );
    } else {
      // Handle the case where receiverEmail or receiverID is null
      // For example, you can navigate to an error page or display an error message.
      return ListTile(
        title: Text(''),
        onTap: () {
          // Handle tap action if needed
        },
        
      );
    }
  }
}
