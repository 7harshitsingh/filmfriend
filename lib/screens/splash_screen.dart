import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: context.width(),
                height: context.height()*0.65,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                width: context.width(),
                height: context.height()*0.35,
              )
            ],
          ),
        ),
      ),
    );
  }
}
