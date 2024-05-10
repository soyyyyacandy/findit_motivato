// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motivato/services/auth/firestore.dart';
import 'package:motivato/theme/light_mode.dart';
import 'package:flutter/rendering.dart'; // Import ScrollDirection
import 'package:motivato/widgets/todo_tile.dart'; // Import your Task_Widget class
import 'package:motivato/pages/create_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}); // Correct the constructor

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

bool show = true;

class _ToDoPageState extends State<ToDoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightMode.colorScheme.background,
      appBar: AppBar(
        backgroundColor: lightMode.colorScheme.primary, // Changed app bar color
        title: Text(
          "Today's Quests",
          style: GoogleFonts.outfit(
            textStyle: TextStyle(
              color: lightMode.colorScheme.background,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: lightMode.colorScheme.background), // Made back button white
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: Visibility(
        //visible: show,
        child: Padding(
          padding: EdgeInsets.all(20.0), // Increased padding
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Add_Screen()),
              );
            },
            backgroundColor: lightMode.colorScheme.primary,
            child: Icon(Icons.add, size: 30),
            shape: CircleBorder(), // Set the shape to circular
          ),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: StreamBuilder<QuerySnapshot>(
            stream: Datasource().stream(), 
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } 
              final noteslist = Datasource().getNotes(snapshot);
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final note = noteslist[index];
                  return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    Datasource().deleteNote(note.id);
                  },
                  child: Task_Widget(note));
                },
                itemCount: noteslist.length,
              );
            }
          ),
        ),
      ),
      //floatingActionButton:
    ); //Scaffold
  }
}
