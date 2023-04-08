import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flimfriend/logic/authcheck.dart';
import 'package:flimfriend/logic/fakeyou_tts.dart';
import 'package:flimfriend/logic/fetch_details.dart';
import 'package:flimfriend/logic/gpt3.dart';
import 'package:flimfriend/screens/get_started_screen.dart';
import 'package:flimfriend/screens/splash_screen.dart';
import 'package:flimfriend/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'logic/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FetchDetails()),
      ChangeNotifierProvider(create: (_) => GPT3()),
      ChangeNotifierProvider(create: (_) => TTS()),
      ChangeNotifierProvider(create: (_) => AuthCheck()),
      ChangeNotifierProvider(create: (_) => GoogleSignInLogic())
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
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const SplashScreen();
            } else {
              return const GetStartedScreen();
            }
          }),
      navigatorKey: navigatorKey,
      scrollBehavior: SBehavior(),
    );
  }
}
