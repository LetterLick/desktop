import 'package:desktop/main_page/mail_navigation/account_item.dart';
import 'package:flutter/material.dart';
import 'package:desktop/logic/mail_controller.dart';

class MailNaviagtion extends StatefulWidget {
  final MailController mailctroller;

  const MailNaviagtion(this.mailctroller, {Key? key}) : super(key: key);

  @override
  State<MailNaviagtion> createState() => _MailNaviagtionState();
}

class _MailNaviagtionState extends State<MailNaviagtion> {
  List<AccountItem> accountItems = [];

  @override
  void initState() {
    widget.mailctroller.setUpdateNavigator = updateNavigator;
    updateNavigator();
    super.initState();
  }

  void createNewEmail() {}

  void updateNavigator() {
    getTree();
  }

  void getTree() async {
    accountItems = [];
    for (var acc in widget.mailctroller.mailAccounts) {
      accountItems.add(AccountItem(
          widget.mailctroller, acc.id, acc.name, await acc.mailboxTree));
    }
    setState(() {
      accountItems = [...accountItems];
    });
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: widget.mailctroller.syncAll,
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
              padding: const EdgeInsets.all(8),
              children: accountItems,
            ),
          )
        ],
      ),
    );
  }
}
