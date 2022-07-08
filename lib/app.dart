import 'package:flutter/material.dart';
import 'main_page/main_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      themeMode: ThemeMode.dark,
      title: "Letter Lick Desktop",
      home: const MainPage(),
    );
  }
}
