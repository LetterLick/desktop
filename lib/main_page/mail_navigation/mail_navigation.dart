import 'package:desktop/main_page/mail_navigation/account_item.dart';
import 'package:flutter/material.dart';
import 'package:desktop/logic/mail_controller.dart';

class MailNaviagtion extends StatelessWidget {
  final MailController mailctroller;
  const MailNaviagtion(this.mailctroller, {Key? key}) : super(key: key);

  void createNewEmail() {}

  void syncEmail() {}

  @override
  Widget build(BuildContext context) {
    const List<AccountItem> accounts = [];

    for (var client in mailctroller.mailClients) {}

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
              ),
              onPressed: createNewEmail,
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.draw_rounded), Text("New message")],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
              ),
              onPressed: syncEmail,
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.sync_outlined), Text("Sync messages")],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8),
              children: [
                AccountItem(),
                AccountItem(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
