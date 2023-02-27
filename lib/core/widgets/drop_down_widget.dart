import 'package:chatgpt/core/constants/color.dart';
import 'package:chatgpt/core/model/models_model.dart';
import 'package:chatgpt/core/services/api_services.dart';
import 'package:chatgpt/core/widgets/text_widget.dart';
import 'package:chatgpt/view_models/dropdownv_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropoDownWidget extends StatefulWidget {
  const DropoDownWidget({super.key});

  @override
  State<DropoDownWidget> createState() => _DropoDownWidgetState();
}

class _DropoDownWidgetState extends State<DropoDownWidget> {
  String? currentModel;
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<DropDownViewModel>(context);
    currentModel = viewmodel.getcurrentModel;
    return FutureBuilder<List<ModelsModel>>(
      future: viewmodel.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : FittedBox(
                child: DropdownButton(
                  dropdownColor: kscaffoldBackgroundColor,
                  iconEnabledColor: kwhiteColor,
                  items: List<DropdownMenuItem<String>>.generate(
                      snapshot.data!.length,
                      (index) => DropdownMenuItem(
                          value: snapshot.data![index].id,
                          child: MyText(
                            title: snapshot.data![index].id,
                          ))),
                  value: currentModel,
                  onChanged: (value) {
                    viewmodel.setCurrentModel(value.toString());
                  },
                ),
              );
      },
    );
  }
}
