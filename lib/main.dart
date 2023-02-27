import 'package:chatgpt/core/constants/color.dart';
import 'package:chatgpt/screens/chat_screen.dart';
import 'package:chatgpt/view_models/chat_view_model.dart';
import 'package:chatgpt/view_models/dropdownv_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DropDownViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatViewModel(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: kscaffoldBackgroundColor,
          appBarTheme: AppBarTheme(color: kcardColor),
        ),
        home: const ChatScreen(),
      ),
    );
  }
}
