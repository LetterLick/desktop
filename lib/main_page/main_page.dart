import 'package:desktop/logic/mail/data/email.dart';
import 'package:desktop/logic/mail/mail_account.dart';
import 'package:desktop/logic/mail_controller.dart';
import 'package:desktop/main_page/mail_content/mail_content.dart';
import 'package:desktop/main_page/mail_list/mail_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'mail_navigation/mail_navigation.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MailController mailController = MailController();
  List<Email> displayMessages = [];
  Email? displayMessageRead;
  Widget drawer = Container();

  void loginEmail() async {
    mailController.addAccount(MailAccount(
        "asdf",
        0,
        dotenv.get("TESTMAIL_DOMAIN"),
        dotenv.get("TESTMAIL_USR"),
        dotenv.get("TESTMAIL_PASSWD")));

    await mailController.connectToAccounts();

    //print(await mail.mailClients[0].listMailBoxes());

    //await mail.selectMailbox(Mailbox("INBOX", "", []));

    //var res = await mail.getEmailIds();
    //print(res);
/*
    for (var id in res[0]) {
      displayMessages.add(await mail.getEmail(id));
    }

    setState(() {
      displayMessages = displayMessages.reversed.toList();
    });
    */
  }

  @override
  void initState() {
    super.initState();
    loginEmail();
  }

  void selectMail(int index) {
    setState(() {
      displayMessageRead = displayMessages[index];
    });
  }

  void closeEmail() {
    setState(() {
      displayMessageRead = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool hideFirst = false;
    bool hideLast = false;
    bool showDrawerButtons = false;
    return Scaffold(
      drawer: Drawer(
        width: 1000 * 0.2,
        child: MailNaviagtion(mailController),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 1000) hideFirst = true;
          if (constraints.maxWidth < 700) hideLast = true;

          //mail content handle
          if (displayMessageRead != null) {
            if (hideLast) {
              return MailContent(
                displayMessageRead!,
                closeEmail,
                closeButtonMode: CloseButtonMode.arrow,
              );
            }
          }

          //mail folder
          if (hideFirst) {
            showDrawerButtons = true;
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LayoutBox(
                  MailNaviagtion(mailController), hideFirst, screenWidth * 0.2),
              Expanded(
                  child: MailList(
                mailController,
                displayMessages,
                selectMail,
                openDrawer:
                    showDrawerButtons ? Scaffold.of(context).openDrawer : null,
              )),
              LayoutBox(
                  displayMessageRead != null
                      ? MailContent(
                          displayMessageRead!,
                          closeEmail,
                          closeButtonMode: CloseButtonMode.cross,
                        )
                      : null,
                  hideLast,
                  screenWidth * 0.5),
            ],
          );
        },
      ),
    );
  }
}

class LayoutBox extends StatelessWidget {
  final bool hide;
  final Widget? child;
  final double width;
  const LayoutBox(this.child, this.hide, this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    if (hide || child == null) return Container();

    return SizedBox(width: width, child: child);
  }
}
