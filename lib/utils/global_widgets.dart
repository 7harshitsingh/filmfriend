import 'package:cached_network_image/cached_network_image.dart';
import 'package:flimfriend/logic/fakeyou_tts.dart';
import 'package:flimfriend/logic/gpt3.dart';
import 'package:flimfriend/model/character_model.dart';
import 'package:flimfriend/screens/character_screen.dart';
import 'package:flimfriend/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

Widget mainContainer(Character ch, BuildContext ctx) {
  String chrName = ch.title;
  return InkWell(
    onTap: () {
      Provider.of<GPT3>(ctx, listen: false)
          .send("system", "Respond to this chat like $chrName", ctx)
          .then((value) {
        Provider.of<TTS>(ctx, listen: false)
            .sendRequest(ch.token, Uuid().v4(),
                Provider.of<GPT3>(ctx, listen: false).resText, ctx)
            .then((val) {
          Provider.of<TTS>(ctx, listen: false).getSpeech(ctx).then((value) {
            CharacterScreen(
              ic: ch,
            ).launch(ctx);
          });
        });
      });
    },
    child: Container(
            height: ctx.width() * 0.4,
            width: ctx.width(),
            color: primaryColor,
            child: Stack(
              //alignment: Alignment.center,
              children: [
                Positioned(
                    right: 0,
                    child: CachedNetworkImage(
                      imageUrl: ch.img,
                      fit: BoxFit.cover,
                      height: ctx.width() * 0.4,
                      width: ctx.width() * 0.3,
                    )),
                Container(
                  width: ctx.width() * 0.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ch.title,
                        overflow: TextOverflow.ellipsis,
                        style: primaryTextStyle(
                            color: textColor.withOpacity(0.7),
                            size: 18,
                            weight: FontWeight.w800,
                            fontFamily:
                                GoogleFonts.cedarvilleCursive().fontFamily),
                      ),
                      //12.height,
                      Text(
                        ch.desc,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: secondaryTextStyle(color: textColor, size: 12),
                      )
                    ],
                  ).paddingAll(16),
                )
              ],
            ))
        .cornerRadiusWithClipRRect(24)
        .paddingSymmetric(horizontal: 24, vertical: 10),
  );
}
