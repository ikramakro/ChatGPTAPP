import 'package:chatgpt/core/model/chat_model.dart';
import 'package:chatgpt/core/services/api_services.dart';
import 'package:flutter/material.dart';

class ChatViewModel with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList => chatList;

  void userMassage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndgetAnswers(
      {required String msg, required String chosenModelId}) async {
    chatList.addAll(
        await ApiServices.sendMassage(msg: msg, modelid: chosenModelId));
  }
}
