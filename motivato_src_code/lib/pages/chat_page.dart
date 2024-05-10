
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:motivato/components/chat_bubble.dart";
import "package:motivato/components/my_textfield.dart";
import "package:motivato/services/auth/auth_service.dart";
import "package:motivato/services/chat/chat_service.dart";

class ChatPage extends StatelessWidget {
  final String recieverEmail;
  final String recieverID;

  ChatPage({
    super.key,
    required this.recieverEmail,
    required this.recieverID,
    });

  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(recieverID, _messageController.text);
      _messageController.clear();
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text(
        recieverEmail ?? '', // Use receiverEmail if not null, otherwise use an empty string
        style: TextStyle(
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    ),
      body: Column(
        children: [
          //display messages
          Expanded(child: _buildMessagelist()),
          //userinput
          _buildUserInput(),
      ],)
    );
  }
  Widget _buildMessagelist() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(recieverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("error");
        } 
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading...");

        }
        return ListView(
          children: 
            snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList()
        );
      }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    
    return Container(
      alignment: alignment,
      child: Column (
        crossAxisAlignment:  isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children : [
          ChatBub(message: data['message'], isCurrentUser: isCurrentUser),
          ]
         )

    );
  }

  //user inp
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom : 50.0),
      child: Row(children: [
        Expanded(
          child: MyTextField(
            controller: _messageController,
            hintText: "Remind your friends!",
            obscureText: false,
      
            )
          ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 78, 77, 77)
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage, 
              icon: const Icon(Icons.send, color: Colors.white,),),
          )
      ],),
    );
  } 
}