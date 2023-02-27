// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt/core/widgets/drop_down_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:chatgpt/core/constants/color.dart';
import 'package:chatgpt/core/services/assets_manager.dart';
import 'package:chatgpt/core/widgets/text_widget.dart';

class ChatWidget extends StatelessWidget {
  String msg;
  int currentindex;
  ChatWidget({
    Key? key,
    required this.msg,
    required this.currentindex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: currentindex == 0 ? kcardColor : kscaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              currentindex == 0
                  ? AssetsManager.uesrImage
                  : AssetsManager.botImage,
              height: 40,
              width: 40,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height * .008,
            ),
            Flexible(
                child: currentindex == 0
                    ? MyText(
                        title: msg,
                      )
                    : DefaultTextStyle(
                        style: TextStyle(
                            color: kwhiteColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 17),
                        child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            repeatForever: false,
                            displayFullTextOnTap: false,
                            totalRepeatCount: 1,
                            animatedTexts: [TyperAnimatedText(msg.trim())]),
                      )),
            currentindex == 1
                ? Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: kwhiteColor,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .008,
                      ),
                      Icon(
                        Icons.thumb_down,
                        color: kwhiteColor,
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
