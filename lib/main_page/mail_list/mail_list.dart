import 'package:flutter/material.dart';
import 'mail_item.dart';

class MailList extends StatelessWidget {
  const MailList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [MailItem(), MailItem(), MailItem()],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
