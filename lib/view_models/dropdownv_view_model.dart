import 'package:chatgpt/core/model/models_model.dart';
import 'package:chatgpt/core/services/api_services.dart';
import 'package:flutter/material.dart';

class DropDownViewModel with ChangeNotifier {
  List<ModelsModel> modelslist = [];
  String currentModel = 'text-davinci-003';
  List<ModelsModel> get getModels => modelslist;
  String get getcurrentModel => currentModel;
  void setCurrentModel(String model) {
    currentModel = model;
    notifyListeners();
  }

  Future<List<ModelsModel>> getAllModels() async {
    modelslist = await ApiServices.getModels();
    return modelslist;
  }
}
