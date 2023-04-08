import 'package:flimfriend/logic/authcheck.dart';
import 'package:flimfriend/screens/authflow/ask_for_api_key.dart';
import 'package:flimfriend/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../logic/details.dart';
import '../logic/gpt3.dart';
import '../utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    APIkey = Provider.of<Details>(context, listen: false).getAPI;
    Provider.of<AuthCheck>(context, listen: false).checkIsItFirstTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      Provider.of<AuthCheck>(context, listen: false).isitfirsttime
          ? AskforAPI().launch(context, isNewTask: true)
          : HomeScreen().launch(context, isNewTask: true);
    });

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.bottomCenter,
                  width: context.width(),
                  height: context.height(),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/splash.png"),
                          fit: BoxFit.cover)),
                  child: CircularProgressIndicator(color: specialColor)
                      .withSize(height: 44, width: 44)
                      .paddingAll(50)),
            ],
          ),
        ),
      ),
    );
  }
}
