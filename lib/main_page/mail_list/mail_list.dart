import 'package:desktop/design.dart';
import 'package:desktop/logic/mail/data/email.dart';
import 'package:desktop/logic/mail_controller.dart';
import 'package:flutter/material.dart';
import 'mail_item.dart';

class MailList extends StatefulWidget {
  final List<Email> emails;
  final Function selectMail;
  final MailController mailController;
  final VoidCallback? openDrawer;

  MailList(this.mailController, this.emails, this.selectMail,
      {this.openDrawer, Key? key})
      : super(key: key);

  @override
  State<MailList> createState() => _MailListState();
}

class _MailListState extends State<MailList> {
  final ScrollController _scrollController = ScrollController();
  int mailCount = -1;
  List<int> mailIdList = [];

  List<MailItem> getMailItemsFromMessages() {
    List<MailItem> items = [];

    for (int i = 0; i < widget.emails.length; i++) {
      items.add(MailItem(widget.emails[i], () => widget.selectMail(i)));
    }
    //remove after testing x2
    for (int i = 0; i < widget.emails.length; i++) {
      items.add(MailItem(widget.emails[i], () => widget.selectMail(i)));
    }
    for (int i = 0; i < widget.emails.length; i++) {
      items.add(MailItem(widget.emails[i], () => widget.selectMail(i)));
    }

    return items;
  }

  Future<void> setMail() async {
    mailIdList = await widget.mailController.search();

    setState(() {
      mailIdList;
      mailCount = mailIdList.length;
    });
  }

  @override
  void initState() {
    widget.mailController.setupdateMailList = setMail;
    super.initState();
  }

  Widget getMailWidget(context, index) {
    return MailItemFuture(widget.mailController, mailIdList[index]);
  }

  @override
  Widget build(BuildContext context) {
    //function nullcheck
    Widget drawerButton = Container();
    if (widget.openDrawer != null) {
      drawerButton = IconButton(
          padding: const EdgeInsets.only(left: 20),
          onPressed: widget.openDrawer!,
          icon: const Icon(Icons.menu));
    }

    int mailCountShow = mailCount;
    if (mailCount == -1) {
      mailCountShow = 0;
    }

    //data check
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
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                itemCount: mailCountShow,
                itemBuilder: getMailWidget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
