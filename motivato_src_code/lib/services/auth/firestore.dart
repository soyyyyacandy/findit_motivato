// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:motivato/model/note_mode.dart';
import 'package:uuid/uuid.dart';


class Datasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> CreateUser(String email) async{
    try {
      await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .set({"id": _auth.currentUser!.uid, "email": email});
        return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addNote(String subtitle, String title, int image) async {
    try {
      var uuid = const Uuid().v4();
      DateTime data = DateTime.now();
      await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection('notes')
        .doc(uuid)
        .set({
          'id' : uuid, 
          'subtitle' : subtitle,
          'isDon' : false,
          'time' : '${data.hour}:${data.minute}',
          'title' : title
        });
      return true;
    } catch (e) {
      print("im sure i worked");
      return false;
    }
  }
  List<Note> getNotes(AsyncSnapshot<QuerySnapshot> snapshot) {
    try {
      final notesList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          data['id'] ?? '', // Add null check for each field
          data['subtitle'] ?? '',
          data['time'] ?? '',
          data['image'] ?? 0, // Provide a default value for int fields
          data['title'] ?? '',
        );
      }).toList();
      return notesList;
    } catch (e) {
      print("Error fetching notes: $e");
      return [];
    }
  }


  Stream<QuerySnapshot> stream(){
    return _firestore
    .collection("users")
    .doc(_auth.currentUser!.uid)
    .collection('notes')
    .snapshots();
  }

  Future<bool> isdone(String uuid, bool isDon) async {
    try {
        await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({'isDon': isDon});
        
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateNote(String uuid, title, subtitle, int image)  async {
    try {
        DateTime data = new DateTime.now();
        await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({
            'subtitle': subtitle,
            'title' : title,
            'image' : image,
            'time' : '${data.hour}:${data.minute}'
            });
        
      return true;
    } catch (e) {
      return false;
  }
  }
  Future <bool> deleteNote(String uuid) async {
    try {
        await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .delete();
        return true;
    } catch (e) {
      print(e);
      return true;

    }


    }
  }