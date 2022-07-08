import 'package:desktop/main_page/mail_content/mail_content.dart';
import 'package:desktop/main_page/mail_list/mail_list.dart';
import 'package:flutter/material.dart';
import 'mail_navigation/mail_navigation.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(children: [
        SizedBox(
          child: MailNaviagtion(),
          width: screenWidth * 0.2,
        ),
        SizedBox(
          child: MailList(),
          width: screenWidth * 0.4,
        ),
        SizedBox(
          child: MailContent(),
          width: screenWidth * 0.4,
        )
      ]),
    );
  }
}
