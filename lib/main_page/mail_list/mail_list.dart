import 'package:enough_mail/smtp.dart';
import 'package:flutter/material.dart';
import 'mail_item.dart';
import '../../logic/mail_controller.dart';

class MailList extends StatelessWidget {
  final List<MimeMessage> emails;
  const MailList(this.emails, {Key? key}) : super(key: key);

  List<MailItem> getMailItemsFromMessages(List<MimeMessage> emails) {
    print("list: ${emails.length}");
    List<MailItem> items = [];

    for (var mail in emails) {
      items.add(MailItem(mail));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: getMailItemsFromMessages(emails),
    );
  }
}
