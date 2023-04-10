import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/character_model.dart';

class Details extends ChangeNotifier {
  final firebaseUser = FirebaseAuth.instance.currentUser;

  Future<void> post(String key) async {
    final controller = FirebaseFirestore.instance
        .collection('controller')
        .doc(firebaseUser!.uid);
    final json = {'api': key};
    await controller.set(json, SetOptions(merge: true));
  }

  String _getAPI = " ";
  String get getAPI => _getAPI;

  Future<void> get() async {
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('controller')
          .doc(firebaseUser!.uid)
          .get()
          .then((info) {
        _getAPI = info.data()!['api'];
      });
      notifyListeners();
    }
  }

  List<Character> list = [];

  List<Character> charactersList() {
    return list;
  }

  Future<void> data() async {
    var characters =
        await FirebaseFirestore.instance.collection("characters").get();
    var character = characters.docs;
    list.clear();
    for (var info in character) {
      list.add(Character.fromJson(info));
    }
  }

}
