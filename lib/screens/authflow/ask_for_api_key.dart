import 'package:flimfriend/screens/authflow/confirm_apikey.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../logic/gpt3.dart';
import '../../utils/colors.dart';

class AskforAPI extends StatefulWidget {
  const AskforAPI({super.key});

  @override
  State<AskforAPI> createState() => _AskforAPIState();
}

class _AskforAPIState extends State<AskforAPI> {
  late final apiController = TextEditingController();

  @override
  void dispose() {
    apiController.dispose();
    super.dispose();
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
                  "Paste your OpenAI API key >>>",
                  style: boldTextStyle(color: Colors.white, size: 30),
                ),
                18.height,
                TextField(
                  maxLines: 3,
                  style: primaryTextStyle(color: specialColor, size: 13),
                  controller: apiController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: specialColor,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    hintText: "Enter APIKey here",
                    hintStyle: primaryTextStyle(
                        color: Colors.white.withOpacity(0.7), size: 14),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                APIkey = apiController.text.toString();
                Provider.of<GPT3>(context, listen: false)
                    .send("system", "Give a welcome greeting in one sentence",
                        context)
                    .then(
                  (value) {
                    bool check =
                        Provider.of<GPT3>(context, listen: false).confirm;
                    check
                        ? ConfirmAPI(
                            k: apiController.text,
                            check: check,
                          ).launch(context, isNewTask: true)
                        : ConfirmAPI(
                            k: apiController.text,
                            check: check,
                          ).launch(context);
                  },
                );
              },
              child: Container(
                height: 44,
                width: context.width(),
                color: specialColor,
                child: Text(
                  "Submit >>>",
                  style: boldTextStyle(color: primaryColorDark, size: 22),
                ).center(),
              ).cornerRadiusWithClipRRect(50),
            ),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 28),
      ),
    );
  }
}
