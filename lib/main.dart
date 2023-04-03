import 'package:flimfriend/logic/fakeyou_tts.dart';
import 'package:flimfriend/logic/gpt3.dart';
import 'package:flimfriend/screens/home_screen.dart';
import 'package:flimfriend/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GPT3()),
      ChangeNotifierProvider(create: (_) => TTS()),
    ],
    child: const FilmFriend(),
    )
  );
}

class FilmFriend extends StatelessWidget {
  const FilmFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: AppTheme.dTheme,
      home: HomeScreen(),
      navigatorKey: navigatorKey,
      scrollBehavior: SBehavior(),
    );
  }
}
