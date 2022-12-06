import 'package:desktop/logic/mail_read.dart';
import 'package:enough_mail/smtp.dart';
import 'package:flutter/material.dart';

class MailItem extends StatelessWidget {
  final MimeMessage mail;

  const MailItem(this.mail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          overlayColor:
              MaterialStateProperty.all(Color.fromARGB(209, 41, 41, 41))),
      onPressed: (() => print("hey")),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.only(top: 7, bottom: 7),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 10),
              child: Icon(
                Icons.circle,
                color:
                    MailRead.getIsSeen(mail, true) ? Colors.blue : Colors.grey,
                size: 15,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              width: 150,
              child: Text(
                MailRead.toReadableList(
                    MailRead.getSenderPersonalName(
                      mail,
                      MailRead.getSenderEmail(mail, ["UNKNOWN"]),
                    ),
                    ", "),
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
            Expanded(
                child: Text(
              MailRead.getSubject(mail, ""),
              overflow: TextOverflow.fade,
              softWrap: false,
            )),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Text(
                MailRead.getDate(mail),
                style: const TextStyle(color: Colors.grey),
                softWrap: false,
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
      ),
    );
  }
}
