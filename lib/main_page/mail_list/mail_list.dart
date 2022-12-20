import 'package:desktop/design.dart';
import 'package:desktop/logic/mail/data/email.dart';
import 'package:flutter/material.dart';
import 'mail_item.dart';

class MailList extends StatelessWidget {
  final List<Email> emails;
  final Function selectMail;
  final VoidCallback? openDrawer;
  final ScrollController _scrollController = ScrollController();
  MailList(this.emails, this.selectMail, {this.openDrawer, Key? key})
      : super(key: key);

  List<MailItem> getMailItemsFromMessages() {
    List<MailItem> items = [];

    for (int i = 0; i < emails.length; i++) {
      items.add(MailItem(emails[i], () => selectMail(i)));
    }
    //remove after testing x2
    for (int i = 0; i < emails.length; i++) {
      items.add(MailItem(emails[i], () => selectMail(i)));
    }
    for (int i = 0; i < emails.length; i++) {
      items.add(MailItem(emails[i], () => selectMail(i)));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    //function nullcheck
    Widget drawerButton = Container();
    if (openDrawer != null) {
      drawerButton = IconButton(
          padding: const EdgeInsets.only(left: 20),
          onPressed: openDrawer!,
          icon: const Icon(Icons.menu));
    }
    return Container(
      color: design.mailListBackgroundColor,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              drawerButton,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: design.mailListItemBackgroundColor,
                      filled: true,
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text("sort"),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                children: getMailItemsFromMessages(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
