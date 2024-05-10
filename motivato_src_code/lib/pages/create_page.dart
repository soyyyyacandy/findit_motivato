import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import 'package:motivato/services/auth/firestore.dart';
import 'package:motivato/theme/light_mode.dart';

class Add_Screen extends StatefulWidget {
  const Add_Screen({Key? key});

  @override
  State<Add_Screen> createState() => _Add_ScreenState();
}

class _Add_ScreenState extends State<Add_Screen> {
  final title = TextEditingController();
  final subtitle = TextEditingController();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  int indexx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightMode.colorScheme.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title_widget(),
            SizedBox(height: 20),
            subtitle_widget(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15), // Adjusted left padding
              child: iconpicker_widget(),
            ),
            SizedBox(height: 20),
            buttons_widget(),
          ],
        ),
      ),
    );
  }

  Widget buttons_widget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: lightMode.colorScheme.primary,
            minimumSize: Size(170, 48),
          ),
          onPressed: () {
            Datasource().addNote(subtitle.text, title.text, indexx);
            Navigator.pop(context);
          },
          child: Text(
            'Add task',
            style: GoogleFonts.outfit( // Apply Outfit font
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: lightMode.colorScheme.tertiary,
            minimumSize: Size(170, 48),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget iconpicker_widget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 10),
          child: Text(
            'Pick an icon:',
            style: GoogleFonts.outfit( // Apply Outfit font
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 80, // Reduced height
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    indexx = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Adjusted border radius
                    border: Border.all(
                      width: 2,
                      color: indexx == index
                          ? lightMode.colorScheme.primary
                          : Colors.grey,
                    ),
                  ),
                  width: 80, // Reduced width
                  height: 80, // Reduced height
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'activity_icons/${index}.png',
                        width: 40, // Reduced image size
                        height: 40, // Reduced image size
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

Widget title_widget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Assign a Quest',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10), // Added spacing between text and text field
        Container(
          decoration: BoxDecoration(
            color: lightMode.colorScheme.secondary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: title,
            focusNode: _focusNode1,
            style: GoogleFonts.outfit(
              fontSize: 18,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              hintText: 'title',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: lightMode.colorScheme.background,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: lightMode.colorScheme.primary,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}


  Widget subtitle_widget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: lightMode.colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          maxLines: 3,
          controller: subtitle,
          focusNode: _focusNode2,
          style: GoogleFonts.outfit( // Apply Outfit font
            fontSize: 18,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: 'subtitle',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: lightMode.colorScheme.background,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: lightMode.colorScheme.primary,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
