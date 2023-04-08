import 'dart:convert';
import 'package:flimfriend/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

String APIkey = "";
String ErrorMessage =
    "You exceeded your current quota, please check your plan and billing details at OpenAI. Buy premium or get APIKey from another account ";

class GPT3 extends ChangeNotifier {
  String resText = "";
  String baseURL = "https://api.openai.com/v1/chat/completions";
  bool confirm = false;

  Map<String, String> getheader(key) {
    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $key"
    };
    return header;
  }

  var list = [];

  Future<void> send(String role, String prompt, BuildContext ctx) async {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return CircularProgressIndicator(
            color: specialColor,
          ).center();
        });

    if (role == "system") {
      list.clear();
    }
    list.add({"role": "$role", "content": "$prompt"});

    var res = await http.post(Uri.parse(baseURL),
        headers: getheader(APIkey),
        body: jsonEncode({"model": "gpt-3.5-turbo", "messages": list}));

    var ch = jsonDecode(res.body.toString());
    if (res.statusCode == 200) {
      confirm = true;
      var message = ch["choices"][0]["message"];
      resText = message["content"].toString();
      list.add({"role": "assistant", "content": resText});
    } else if (res.statusCode == 401) {
      print(res.body.toString());
      print(APIkey);
      resText = ch['error']['message'].toString();
    } else {
      print(res.body.toString());
      print(res.statusCode);
      resText = ErrorMessage;
    }

    Navigator.of(ctx).pop();
  }
}
