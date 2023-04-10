import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flimfriend/logic/details.dart';
import 'package:flimfriend/model/character_model.dart';
import 'package:flimfriend/utils/app_theme.dart';
import 'package:flimfriend/utils/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../utils/colors.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser!;

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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () async {
                              final url =
                                  "https://t.ly/y4Fe";
                              await Share.share(
                                  "Try out FilmFriend, Lets engage and talk with your favourite movie characters. Yes, you heard right now its possible, 110% you gonna love it. Get it rn...\n\n$url");
                            },
                            child: Icon(
                              Icons.share,
                              size: 36,
                              color: textColor.withOpacity(0.7),
                            )),
                        16.width,
                        Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    color: textColor.withOpacity(0.7),
                                    width: 1.5)),
                            child: CachedNetworkImage(
                              imageUrl: firebaseUser.photoURL!,
                              fit: BoxFit.cover,
                            ).cornerRadiusWithClipRRect(100)),
                      ],
                    )
                  ]).paddingSymmetric(horizontal: 32, vertical: 32),
              //mainContainer(charactersList()[0], context)
              Consumer<Details>(builder: ((context, value, child) {
                return FutureBuilder(
                    future: value.data(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: specialColor,
                        ).center();
                      }
                      value.charactersList().shuffle();
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          Character entry = value.charactersList()[index];
                          return mainContainer(entry, context);
                        },
                        itemCount: value.charactersList().length,
                      );
                    });
              })),
              16.height,
              Text(
                "Due to financials constraints, we currently dependent on free APIs from the providers. So, Please maintain patience",
                maxLines: 2,
                style: secondaryTextStyle(
                    color: textColor.withOpacity(0.7),
                    size: 10,
                    weight: FontWeight.w400,
                    fontStyle: FontStyle.italic),
              ).paddingSymmetric(horizontal: 32),
              24.height,
            ],
          ),
        ),
      ),
    );
  }
}
