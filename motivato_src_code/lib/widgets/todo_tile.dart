// ignore_for_file: camel_case_types, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import 'package:motivato/model/note_mode.dart';
import 'package:motivato/services/auth/firestore.dart';
import 'package:motivato/theme/light_mode.dart';
import 'package:motivato/pages/edit_page.dart';

// ignore: must_be_immutable
class Task_Widget extends StatefulWidget {
  final Note _note;
  const Task_Widget(this._note,{super.key});
  
  @override
  
  State<Task_Widget> createState() => _Task_WidgetState();
}



class _Task_WidgetState extends State<Task_Widget> {
  @override
  Widget build(BuildContext context) {
    return get();
  }

  Widget get() {
    bool isDone = false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: lightMode.colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: lightMode.colorScheme.shadow.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              todoicon(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget._note.title,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Checkbox(
                          value: isDone,
                          onChanged: (value) {
                            setState(() {
                              isDone = !isDone;
                            });
                            Datasource().isdone(widget._note.id, isDone);
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget._note.subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: lightMode.colorScheme.shadow,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 90,
                            height: 28,
                            decoration: BoxDecoration(
                              color: lightMode.colorScheme.primary,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: Image.asset(
                                      'images/clock.png',
                                      width: 16,
                                      height: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget._note.time,
                                    style: TextStyle(
                                      color: lightMode.colorScheme.background,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Edit_Screen(widget._note),
                                ),
                              );
                            },
                            child: Container(
                              width: 90,
                              height: 28,
                              decoration: BoxDecoration(
                                color: lightMode.colorScheme.primary,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: Image.asset(
                                        'images/note.png',
                                        width: 16,
                                        height: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'edit',
                                      style: TextStyle(
                                        color: lightMode.colorScheme.background,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget todoicon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: lightMode.colorScheme.background,
          image: DecorationImage(
            image: AssetImage('activity_icons/${widget._note.image}.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
