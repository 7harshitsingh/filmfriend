import 'package:cloud_firestore/cloud_firestore.dart';

class Character {
  String img;
  String title;
  String desc;
  String token;
  List<String> ques;

  Character({
    required this.img,
    required this.title,
    required this.desc,
    required this.token,
    required this.ques,
  });

  factory Character.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return Character(
      img: json['img'],
      title: json['title'],
      desc: json['desc'],
      token: json['token'],
      ques:  List.from(json['ques'])
    );
  }
}
