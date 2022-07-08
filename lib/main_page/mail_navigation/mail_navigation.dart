import 'package:flutter/material.dart';

class MailNaviagtion extends StatelessWidget {
  const MailNaviagtion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Icon(Icons.mail), Icon(Icons.send)],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
