import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Details extends ChangeNotifier {
  final firebaseUser = FirebaseAuth.instance.currentUser;

  Future<void> post(String key) async {
    final inst = FirebaseFirestore.instance
        .collection('controller')
        .doc(firebaseUser!.uid);
    final json = {'api': key};
    await inst.set(json).then((value) {
      get();
    });
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
}
