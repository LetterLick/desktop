import 'package:desktop/logic/mail/data/email.dart';
import 'package:flutter/material.dart';

enum CloseButtonMode { none, cross, arrow }

class MailContent extends StatelessWidget {
  final Email mail;
  final VoidCallback close;
  final CloseButtonMode closeButtonMode;
  const MailContent(this.mail, this.close,
      {this.closeButtonMode = CloseButtonMode.none, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //close buttons
    Widget arrowClose = Row(
      children: [
        IconButton(onPressed: close, icon: const Icon(Icons.arrow_back))
      ],
    );
    Widget crossClose = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [IconButton(onPressed: close, icon: const Icon(Icons.close))],
    );
    Widget closeButton = Container();

    if (closeButtonMode == CloseButtonMode.arrow) closeButton = arrowClose;
    if (closeButtonMode == CloseButtonMode.cross) closeButton = crossClose;

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(204, 65, 63, 63),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          closeButton,
          Text(
            mail.subject,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("sent: ${mail.fromEmail.toString()}"),
          Text("To: ${mail.toEmail.toString()}"),
          Expanded(
            child: Container(child: Text(mail.text)),
          ),
        ],
      ),
    );
  }
}
