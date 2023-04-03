import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../logic/fakeyou_tts.dart';
import '../utils/colors.dart';

class ResponseScreen extends StatefulWidget {
  final String resText;
  const ResponseScreen({super.key, required this.resText});

  @override
  State<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  final audio = AudioPlayer();
  late Source src;

  @override
  void dispose() {
    audio.dispose();
    super.dispose();
  }

  @override
  void initState() {
    playAudio();
    super.initState();
  }

  void playAudio() async {
    src = UrlSource(
        Provider.of<TTS>(context, listen: false).finalURL);
    audio.play(src).then((value) {
      print("playing");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height(),
        width: context.width(),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColorDark,
              primaryColor,
            ],
            tileMode: TileMode.decal,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    //margin: const EdgeInsets.all(8),
                    decoration: boxDecorationWithRoundedCorners(
                      backgroundColor: transparentColor,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: textColor.withOpacity(0.8)),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: textColor,
                    ).paddingAll(7),
                  ).onTap(() {
                    finish(context);
                  }),
                  16.width,
                  Text(
                    "Ask Again",
                    style: primaryTextStyle(
                        size: 22, weight: FontWeight.bold, color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
              16.height,
              Text(
                widget.resText,
                style: primaryTextStyle(
                    size: 18, weight: FontWeight.bold, color: specialColor),
              ),
            ],
          ).paddingAll(24),
        ),
      ),
    );
  }
}
