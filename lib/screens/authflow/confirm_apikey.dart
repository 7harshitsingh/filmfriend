import 'package:flimfriend/logic/authcheck.dart';
import 'package:flimfriend/logic/details.dart';
import 'package:flimfriend/logic/gpt3.dart';
import 'package:flimfriend/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';

class ConfirmAPI extends StatelessWidget {
  final String k;
  final bool check;
  const ConfirmAPI({super.key, required this.k, required this.check});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                60.height,
                Text(
                  "Welcome >>>",
                  style: boldTextStyle(color: Colors.white, size: 30),
                ),
                18.height,
                SingleChildScrollView(
                  child: Container(
                      height: context.width(),
                      width: context.width(),
                      child: Text(
                        Provider.of<GPT3>(context, listen: false).resText,
                        style: boldTextStyle(
                            size: 16, color: Colors.white.withOpacity(0.7)),
                      ).paddingAll(12)),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                check
                    ? {
                        Provider.of<Details>(context, listen: false)
                            .post(k)
                            .then((value) {
                          Provider.of<AuthCheck>(context, listen: false)
                              .updateisitfirsttime()
                              .then((value) {
                            HomeScreen().launch(context, isNewTask: true);
                          });
                        })
                      }
                    : toast(
                        "Either your provided API wasn't correct or your free OpenAI quota was over. If you're confident with your credentials, Please try again ...");
              },
              child: Container(
                height: 44,
                width: context.width(),
                color: check ? specialColor : grey,
                child: Text(
                  "Enter >>>",
                  style: boldTextStyle(
                      color: check ? primaryColorDark : Colors.white, size: 22),
                ).center(),
              ).cornerRadiusWithClipRRect(50),
            ),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 28),
      ),
    );
  }
}
