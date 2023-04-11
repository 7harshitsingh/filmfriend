import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

String refreshToken = "";

class TTS extends ChangeNotifier {
  String postURL = "https://api.fakeyou.com/tts/inference";
  String getURL = "https://api.fakeyou.com/tts/job/";
  String googleAPIsStorageURL = "https://storage.googleapis.com/vocodes-public";
  String finalURL = "";
  String getEndPoint = "";

  Map<String, String> Pheader = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "cookie": "$refreshToken"
  };

  Future<void> sendRequest(
      String token, String uuid4, String request, BuildContext ctx) async {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return CircularProgressIndicator(
            color: specialColor,
          ).center();
        });

    var req = await http.post(Uri.parse(postURL),
        headers: Pheader,
        body: jsonEncode({
          "tts_model_token": token,
          "uuid_idempotency_token": uuid4,
          "inference_text": request
        }));

    if (req.statusCode == 200) {
      var data = jsonDecode(req.body.toString());
      getEndPoint = data["inference_job_token"].toString();
      print("Stage2 completed");
      print(getEndPoint);
    } else {
      toast("Unable to generate speech");
    }

    Navigator.of(ctx).pop();
  }

  Map<String, String> Gheader = {
    "Accept": "application/json",
  };

  Future<void> getSpeech(BuildContext ctx) async {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return CircularProgressIndicator(
            color: specialColor,
          ).center();
        });

    while (true) {
      var get = await http.get(
        Uri.parse(getURL + getEndPoint),
        headers: Gheader,
      );

      var data = jsonDecode(get.body.toString());
      if (get.statusCode == 200) {
        print(data["state"]["status"].toString());
        if (data["state"]["status"].toString() == "complete_success") {
          finalURL = googleAPIsStorageURL +
              data["state"]["maybe_public_bucket_wav_audio_path"].toString();
          print("Stage3 completed");
          print(finalURL);
          break;
        }
        continue;
      } else {
        toast("Sorry!");
        break;
      }
    }

    Navigator.of(ctx).pop();
  }

  String loginURL = "https://api.fakeyou.com/login";

  Map<String, String> Loginheader = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  Future<void> login() async {
    var req = await http.post(Uri.parse(loginURL),
        headers: Loginheader,
        body: jsonEncode({
          "username_or_email": dotenv.env['USERNAME'].toString(),
          "password": dotenv.env['PASSWORD'].toString()
        }));

    refreshToken = req.headers['set-cookie']!;
    // int index = rawCookie.indexOf(';');
    // refreshToken = (index == -1) ? rawCookie : rawCookie.substring(0, index);
  }
}
