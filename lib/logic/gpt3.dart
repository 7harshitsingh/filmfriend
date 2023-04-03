import 'dart:convert';
import 'package:flimfriend/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

String APIkey = "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";

class GPT3 extends ChangeNotifier {
  String resText = "";
  String baseURL = "https://api.openai.com/v1/chat/completions";

  Map<String, String> header = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $APIkey"
  };

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
        headers: header,
        body: jsonEncode({"model": "gpt-3.5-turbo", "messages": list}));

    var ch = jsonDecode(res.body.toString());
    if (res.statusCode == 200) {
      var message = ch["choices"][0]["message"];
      resText = message["content"].toString();
      list.add({"role": "assistant", "content": resText});
    } else {
      print(res.body.toString());
      resText =
          "You exceeded your current quota, please check your plan and billing details at OpenAI";
    }

    Navigator.of(ctx).pop();
  }
}
