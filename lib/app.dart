import 'package:flutter/material.dart';
import 'main_page/main_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Letter Lick Desktop",
      home: MainPage(),
    );
  }
}
