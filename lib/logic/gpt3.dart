import 'dart:convert';
import 'package:flimfriend/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

String APIkey = "";

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
      resText = ch['error']['message'].toString();
    } else if (res.statusCode == 429) {
      confirm = true;
      resText = ch['error']['message'].toString();
    }else {
      resText = res.statusCode.toString() + "Status Error";
    }

    Navigator.of(ctx).pop();
  }
}
