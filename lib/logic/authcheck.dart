import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthCheck extends ChangeNotifier {
  
  AuthCheck() {
    checkIsItFirstTime();
  }

  bool _isitfirsttime = true;
  bool get isitfirsttime => _isitfirsttime;
  final firebaseUser = FirebaseAuth.instance.currentUser;

  Future<void> checkIsItFirstTime() async {
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('controller')
          .doc(firebaseUser!.uid)
          .get()
          .then((info) {
        _isitfirsttime = info.data()!['isitfirsttime'];
        notifyListeners();
      });
    }
  }

  Future<void> updateisitfirsttime() async {
    final controller = FirebaseFirestore.instance
        .collection('controller')
        .doc(firebaseUser!.uid);
    final json = {'isitfirsttime': false};
    await controller.set(json);
    checkIsItFirstTime();
  }
}
