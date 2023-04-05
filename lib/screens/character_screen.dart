import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flimfriend/logic/fakeyou_tts.dart';
import 'package:flimfriend/screens/response_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:uuid/uuid.dart';

import '../logic/gpt3.dart';
import '../model/character_model.dart';
import '../utils/colors.dart';

// ignore: must_be_immutable
class CharacterScreen extends StatefulWidget {
  final Character ic;
  const CharacterScreen({super.key, required this.ic});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
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
    _initSpeech();
  }

  void playAudio() async {
    src = UrlSource(Provider.of<TTS>(context, listen: false).finalURL);
    audio.play(src).then((value) {
      print("playing");
    });
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: Duration(seconds: 10),
    );
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    String chrName = widget.ic.title;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AvatarGlow(
        animate: _speechEnabled,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 56.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
            onPressed: () {
              _speechToText.isNotListening
                  ? _startListening()
                  : _stopListening();
            },
            backgroundColor: specialColor,
            child: _speechToText.isNotListening
                ? FaIcon(
                    FontAwesomeIcons.microphone,
                    color: primaryColor,
                  )
                : Icon(
                    Icons.stop,
                    color: primaryColor,
                  )),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: CachedNetworkImageProvider(
            widget.ic.img,
          ),
          fit: BoxFit.cover,
        )),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              32.height,
              Text(
                widget.ic.title,
                style: primaryTextStyle(
                    color: textColor.withOpacity(0.7),
                    size: 28,
                    weight: FontWeight.bold),
              ).paddingSymmetric(horizontal: 32, vertical: 32),
              Text(
                widget.ic.desc,
                maxLines: 100,
                overflow: TextOverflow.ellipsis,
                style: secondaryTextStyle(
                    color: textColor, size: 12, weight: FontWeight.w400),
              ).paddingSymmetric(horizontal: 32),
              10.height,
              Text(
                "Don't ask anything else, if you ask from the plot of the character, it was really fun. Otherwise you may get apologies or foul response. TC...",
                maxLines: 3,
                style: secondaryTextStyle(
                    color: textColor,
                    size: 10,
                    weight: FontWeight.w400,
                    fontStyle: FontStyle.italic),
              ).paddingSymmetric(horizontal: 32),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColorDark.withOpacity(0.6),
                      primaryColorDark.withOpacity(0.3),
                    ],
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prompt',
                      style: primaryTextStyle(
                          size: 18,
                          weight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.7)),
                    ),
                    _lastWords == ''
                        ? Text(
                            Provider.of<GPT3>(context, listen: false).resText,
                            style: primaryTextStyle(
                                size: 16,
                                weight: FontWeight.bold,
                                color: specialColor),
                          )
                        : Text(
                            '$_lastWords',
                            style: primaryTextStyle(
                                size: 16,
                                weight: FontWeight.bold,
                                color: specialColor),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _lastWords = '';
                            });
                          },
                          child: Container(
                            height: 48,
                            width: 48,
                            color: primaryColor,
                            child: Icon(
                              Icons.cancel,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ).cornerRadiusWithClipRRect(100).paddingAll(8),
                        ),
                        InkWell(
                          onTap: () {
                            _lastWords != ''
                                ? Provider.of<GPT3>(context, listen: false)
                                    .send("user", _lastWords, context)
                                    .then((value) {
                                    Provider.of<TTS>(context, listen: false)
                                        .sendRequest(
                                            widget.ic.token,
                                            Uuid().v4(),
                                            Provider.of<GPT3>(context,
                                                    listen: false)
                                                .resText,
                                            context)
                                        .then((value) {
                                      Provider.of<TTS>(context, listen: false)
                                          .getSpeech(context)
                                          .then((value) {
                                        ResponseScreen(
                                                resText: Provider.of<GPT3>(
                                                        context,
                                                        listen: false)
                                                    .resText)
                                            .launch(context);
                                      });
                                    });
                                  })
                                : toast("Please ask something to $chrName");
                          },
                          child: Container(
                            height: 48,
                            width: 48,
                            color: primaryColor,
                            child: Icon(
                              Icons.send,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ).cornerRadiusWithClipRRect(100).paddingAll(8),
                        )
                      ],
                    )
                  ],
                ).paddingAll(16),
              )
                  .cornerRadiusWithClipRRect(24)
                  .paddingSymmetric(vertical: 24, horizontal: 20),
              60.height,
            ],
          ),
        ),
      ),
    );
  }
}
