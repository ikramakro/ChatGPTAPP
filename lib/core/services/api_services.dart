import 'dart:convert';
import 'dart:developer';

import 'package:chatgpt/core/constants/api_constant.dart';
import 'package:chatgpt/core/model/chat_model.dart';
import 'package:chatgpt/core/model/models_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var respons = await http.get(Uri.parse('$BaseUrl/models'),
          headers: {'Authorization': 'Bearer $API_KEY'});

      Map jsonresponse = jsonDecode(respons.body);
      // log('jsonresponse $jsonresponse');
      List temp = [];
      for (var value in jsonresponse['data']) {
        temp.add(value);
        //acces the id only
        // log('temp ${value['id']}');
      }
      return ModelsModel.modelsformSnapshot(temp);
    } catch (error) {
      log('error $error');
      rethrow;
    }
  }

  static Future<List<ChatModel>> sendMassage(
      {required String msg, required String modelid}) async {
    try {
      var respons = await http.post(Uri.parse('$BaseUrl/completions'),
          headers: {
            'Authorization': 'Bearer $API_KEY',
            'Content-Type': 'application/json'
          },
          body:
              jsonEncode({"model": modelid, "prompt": msg, "max_tokens": 100}));

      Map jsonresponse = jsonDecode(respons.body);
      List<ChatModel> chatList = [];
      if (jsonresponse['choices'].length > 0) {
        // log('jsonresponse[choices] Text ${jsonresponse['choices'][0]['text']}');
        chatList = List.generate(
            jsonresponse['choices'].length,
            (index) => ChatModel(
                  msg: jsonresponse['choices'][index]['text'],
                  chatIndex: 1,
                ));
      }
      return chatList;
    } catch (error) {
      log('error $error');
      rethrow;
    }
  }
}
