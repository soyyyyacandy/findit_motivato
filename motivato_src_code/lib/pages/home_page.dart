import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motivato/theme/light_mode.dart';
import 'package:motivato/services/auth/auth_service.dart';
import 'package:motivato/services/chat/chat_service.dart';
import 'package:motivato/pages/todo_page.dart';
import 'package:motivato/components/streak.dart';
import 'package:motivato/pages/all_chats_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) {
    //_chatService = ChatService();
    //_auth = const AuthService();
  }

  final ChatService _chatService = ChatService();
  final AuthService _auth = AuthService();

  void logout(BuildContext context) {
    final AuthService _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightMode.colorScheme.primary,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: lightMode.colorScheme.primaryContainer, // Set container color here
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hey, Adventurer!",
                              style: GoogleFonts.outfit(
                                textStyle: TextStyle(
                                  color: lightMode.colorScheme.background,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Level: 1',
                              style: TextStyle(color: lightMode.colorScheme.background),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                lightMode.colorScheme.tertiary,
                                lightMode.colorScheme.surfaceTint,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 32,
                            backgroundColor: lightMode.colorScheme.primary,
                            child: ClipOval(
                              child: Image.asset(
                                'pixelpfps/8.jpg',
                                fit: BoxFit.cover,
                                width: 60,
                                height: 60,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0, top: 25, left: 25),
              child: ChatView(context),
            ),
            
            BodyBar(context),
          ],
        ),
      ),
    );
  }
  
  Widget BodyBar(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: lightMode.colorScheme.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: lightMode.colorScheme.inversePrimary.withOpacity(1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "You're on a Streak!",
                        style: GoogleFonts.outfit(
                          textStyle: TextStyle(
                            color: lightMode.colorScheme.inversePrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      StreakBar(streak: 4, maxStars: 5, starSize: 48),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "View Quests",
                        style: GoogleFonts.outfit(
                          textStyle: TextStyle(
                            color: lightMode.colorScheme.inversePrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ToDoPage()),
                          );
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: lightMode.colorScheme.inversePrimary,
                        ),
                      ),
                    ],
                  ),
                  MainTile(
                    title: 'Go on a walk',
                    imageFilename: '1',
                  ),
                  MainTile(
                    title: 'Drink water',
                    imageFilename: '0',
                  ),
                  MainTile(
                    title: 'Do homework',
                    imageFilename: '2',
                  ),
                  SizedBox(height: 30), // Add some space between the MainTile and the Icon
                  GestureDetector(
                    onTap: () => logout(context), // Call logout function
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 24,
                          color: lightMode.colorScheme.shadow,
                        ),
                        SizedBox(width: 8), // Add some space between the icon and text
                        Text(
                          'Log out',
                          style: TextStyle(
                            color: lightMode.colorScheme.shadow,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget MainTile({required String title, required String imageFilename}) {
  return Column(
    children: [
      SizedBox(height: 12),
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: lightMode.colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: lightMode.colorScheme.shadow.withOpacity(0.2), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 4, // Blur radius
              offset: Offset(0, 2), // Offset from the container
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 8),
            Image.asset(
              'activity_icons/$imageFilename.png',
              width: 24, // Adjust the width as needed
              height: 24, // Adjust the height as needed
            ),
            SizedBox(width: 16), // Add some space between the image and the text
            Text(
              title,
              style: GoogleFonts.outfit(
                textStyle: TextStyle(
                  color: lightMode.colorScheme.inversePrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

  Widget ChatView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Chats",
              style: GoogleFonts.outfit(
                textStyle: TextStyle(
                  color: lightMode.colorScheme.background,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllChatPage()),
                );
              },
              child: Icon(
                Icons.more_horiz,
                color: lightMode.colorScheme.background,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(top: 15),
          height: 130,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              buildAvatar('Rene', '1'),
              buildAvatar('Liana', '2'),
              buildAvatar('Syl', '3'),
              buildAvatar('Mark', '4'),
              buildAvatar('Jane', '5'),
              buildAvatar('Amanda', '6'),
              buildAvatar('Jackson', '7'),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAvatar(String name, String filename) {
    return Padding(
      padding: const EdgeInsets.only(right:20),
      child: Column(
        children:[
          CircleAvatar(
            radius: 25,
            backgroundColor: lightMode.colorScheme.background,
            backgroundImage: Image.asset('pixelpfps/$filename.jpg').image,
          ),
          SizedBox(height: 8,),
          Text(
            name,
            style: GoogleFonts.outfit(
              textStyle: TextStyle(
                color: lightMode.colorScheme.background,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              )
              ),
          ),
        ],
      ),
    );
  }
}


