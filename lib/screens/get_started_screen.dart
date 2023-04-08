import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../logic/google_sign_in.dart';
import '../utils/colors.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

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
                alignment: Alignment.bottomCenter,
                width: context.width(),
                height: context.height(),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/splash.png"),
                        fit: BoxFit.cover)),
                child: InkWell(
                  onTap: () {
                    final provider = Provider.of<GoogleSignInLogic>(context,
                        listen: false);
                    provider.googleLogin(context);
                  },
                  child: Container(
                    height: 44,
                    width: context.width(),
                    color: specialColor,
                    child: Text(
                      "Get Started >>>",
                      style:
                          boldTextStyle(color: primaryColorDark, size: 22),
                    ).center(),
                  ).cornerRadiusWithClipRRect(50).paddingSymmetric(horizontal: 20, vertical: 28),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
