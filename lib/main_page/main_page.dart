import 'package:desktop/logic/mail_controller.dart';
import 'package:desktop/main_page/mail_content/mail_content.dart';
import 'package:desktop/main_page/mail_list/mail_list.dart';
import 'package:enough_mail/smtp.dart';
import 'package:flutter/material.dart';
import 'mail_navigation/mail_navigation.dart';
import 'package:resizable_widget/resizable_widget.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MailController mail = MailController();
  List<MimeMessage> displayMessages = [];

  void test() async {
    await mail.autoDiscover("Bolli test", "test@bolli.dev", "XTdR4Z7yatBwuU");

    List<MimeMessage> temp = [];

    temp = await mail.getEmails();

    this.setState(() {
      displayMessages = [...temp];
    });
    print(displayMessages.length);
  }

  @override
  void initState() {
    super.initState();
    test();
  }

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
          child: MailList(displayMessages),
          width: screenWidth * 0.4,
        ),
        SizedBox(
          child: MailContent(),
          width: screenWidth * 0.4,
        ),
      ]),
    );
  }
}
