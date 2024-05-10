import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget{
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('H O M E'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('M E N U'),
            onTap: () {
              Navigator.pop(context);
            
            },
          ),
        ],
      ),
    );
  }
}