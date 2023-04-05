import 'package:cached_network_image/cached_network_image.dart';
import 'package:flimfriend/model/character_model.dart';
import 'package:flimfriend/utils/app_theme.dart';
import 'package:flimfriend/utils/default_data.dart';
import 'package:flimfriend/utils/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<Character> list_ = charactersList();

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
              32.height,
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appName + "...",
                          style: primaryTextStyle(
                              color: textColor.withOpacity(0.7),
                              size: 28,
                              weight: FontWeight.bold),
                        ),
                        Text(
                          "TALK WITH MOVIE CHARACTERS",
                          style: secondaryTextStyle(
                              color: textColor.withOpacity(0.7),
                              size: 10,
                              weight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: textColor.withOpacity(0.7), width: 1.5)),
                      child: CachedNetworkImage(
                        imageUrl: "https://image.lexica.art/full_jpg/f1f9e42f-97d1-4860-8e7c-859fcb6b581a",
                        fit: BoxFit.cover,
                      ).cornerRadiusWithClipRRect(100)
                    )
                  ]).paddingSymmetric(horizontal: 32, vertical: 32),
              //mainContainer(charactersList()[0], context)
              ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  Character entry = list_[index];
                  return mainContainer(entry, context);
                },
                itemCount: list_.length,
              ),
              64.height,
            ],
          ),
        ),
      ),
    );
  }
}
