import 'dart:developer';

import 'package:chatgpt/core/constants/color.dart';
import 'package:chatgpt/core/model/chat_model.dart';
import 'package:chatgpt/core/services/api_services.dart';
import 'package:chatgpt/core/services/assets_manager.dart';
import 'package:chatgpt/core/widgets/chat_widget.dart';
import 'package:chatgpt/core/widgets/drop_down_widget.dart';
import 'package:chatgpt/core/widgets/text_widget.dart';
import 'package:chatgpt/view_models/chat_view_model.dart';
import 'package:chatgpt/view_models/dropdownv_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController controller;
  late FocusNode focusNode;
  late ScrollController scrollController;
  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<DropDownViewModel>(context);
    final chatviewmodel = Provider.of<ChatViewModel>(context);

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.openaiImage),
          ),
          elevation: 2,
          title: const Text('ChatGpt'),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: kcardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                title: 'Chosen Option',
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Flexible(flex: 2, child: DropoDownWidget())
                            ],
                          ),
                        );
                      });
                },
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: kwhiteColor,
                ))
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: scrollController,
                itemCount: chatviewmodel.getChatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    currentindex: chatviewmodel.getChatList[index].chatIndex,
                    msg: chatviewmodel.getChatList[index].msg,
                  );
                },
              ),
            ),
            if (_isTyping) ...[
              SpinKitThreeBounce(
                color: kwhiteColor,
                size: 20,
              ),
            ],
            Material(
              color: kcardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        style: TextStyle(color: kwhiteColor),
                        controller: controller,
                        onSubmitted: (value) async {
                          await sendMassageFCT(viewmodel, chatviewmodel);
                        },
                        decoration: InputDecoration(
                          hintText: 'How can I help you',
                          hintStyle: TextStyle(color: kwhiteColor),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          await sendMassageFCT(viewmodel, chatviewmodel);
                        },
                        icon: Icon(
                          Icons.send,
                          color: kwhiteColor,
                        ))
                  ],
                ),
              ),
            )
          ],
        )));
  }

  void scrollListoEnd() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2), curve: Curves.ease);
  }

  Future<void> sendMassageFCT(
      DropDownViewModel viewmodel, ChatViewModel chatViewModel) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: MyText(
            title: 'You can\'t send multipul message it a time',
          ),
          backgroundColor: kredColor,
        ),
      );
      return;
    }
    if (controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: MyText(
            title: 'Please type the message',
          ),
          backgroundColor: kredColor,
        ),
      );
      return;
    }
    try {
      String controllertext = controller.text;
      setState(() {
        _isTyping = true;
        chatViewModel.userMassage(msg: controllertext);
        controller.clear();
        focusNode.unfocus();
      });
      chatViewModel.sendMessageAndgetAnswers(
          msg: controllertext, chosenModelId: viewmodel.currentModel);

      log('Requist is send');

      setState(() {});
    } catch (e) {
      log('error $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: MyText(
            title: e.toString(),
          ),
          backgroundColor: kredColor,
        ),
      );
    } finally {
      setState(() {
        _isTyping = false;
        scrollListoEnd();
      });
    }
  }
}
